require 'rexml/document'

module Jekyll

  # Change MY_URL to reflect the site you are using
  MY_URL = "http://www.yzjoey.com"

  # Change SITEMAP_FILE_NAME if you would like your sitemap file
  # to be called something else
  SITEMAP_FILE_NAME = "sitemap.xml"

  # Any files to exclude from being included in the sitemap.xml
  EXCLUDED_FILES = ["atom.xml"]

  # Any files that include posts, so that when a new post is added, the last
  # modified date of these pages should take that into account
  PAGES_INCLUDE_POSTS = ["index.html"]

  # Custom variable names for changefreq and priority elements
  # These names are used within the YAML Front Matter of pages or posts
  # for which you want to include these properties
  CHANGE_FREQUENCY_CUSTOM_VARIABLE_NAME = "weekly"
  PRIORITY_CUSTOM_VARIABLE_NAME = "priority"

  class Post
    attr_accessor :name

    def full_path_to_source
      File.join(@base, @name)
    end

    def location_on_server
      "#{MY_URL}#{url}"
    end
  end

  class Page
    attr_accessor :name

    def full_path_to_source
      File.join(@base, @dir, @name)
    end

    def location_on_server
      location = "#{MY_URL}#{@dir}#{url}"
      location.gsub(/index.html$/, "")
    end
  end

  class Layout
    def full_path_to_source
      File.join(@base, @name)
    end
  end

  # Recover from strange exception when starting server without --auto
  class SitemapFile < StaticFile
    def write(dest)
      begin
        super(dest)
      rescue
      end

      true
    end
  end

  class SitemapGenerator < Generator

    # Valid values allowed by sitemap.xml spec for change frequencies
    VALID_CHANGE_FREQUENCY_VALUES = ["always", "hourly", "daily", "weekly",
      "monthly", "yearly", "never"] 

    # Goes through pages and posts and generates sitemap.xml file
    #
    # Returns nothing
    def generate(site)
      sitemap = REXML::Document.new << REXML::XMLDecl.new("1.0", "UTF-8")

      urlset = REXML::Element.new "urlset"
      urlset.add_attribute("xmlns", 
        "http://www.sitemaps.org/schemas/sitemap/0.9")

      @last_modified_post_date = fill_posts(site, urlset)
      fill_pages(site, urlset)

      sitemap.add_element(urlset)

      # File I/O: create sitemap.xml file and write out pretty-printed XML
      file = File.new(File.join(site.dest, SITEMAP_FILE_NAME), "w")
      formatter = REXML::Formatters::Pretty.new(4)
      formatter.compact = true
      formatter.write(sitemap, file)
      file.close

      # Keep the sitemap.xml file from being cleaned by Jekyll
      site.static_files << Jekyll::SitemapFile.new(site, site.dest, "/", SITEMAP_FILE_NAME)
    end

    # Create url elements for all the posts and find the date of the latest one
    #
    # Returns last_modified_date of latest post
    def fill_posts(site, urlset)
      last_modified_date = nil
      site.posts.each do |post|
        if !excluded?(post.name)
          url = fill_url(site, post)
          urlset.add_element(url)
        end

        path = post.full_path_to_source
        date = File.mtime(path)
        last_modified_date = date if last_modified_date == nil or date > last_modified_date
      end

      last_modified_date
    end

    # Create url elements for all the normal pages and find the date of the
    # index to use with the pagination pages
    #
    # Returns last_modified_date of index page
    def fill_pages(site, urlset)
      site.pages.each do |page|
        if !excluded?(page.name)
          path = page.full_path_to_source
          if File.exists?(path)
            url = fill_url(site, page)
            urlset.add_element(url)
          end
        end
      end
    end

    # Fill data of each URL element: location, last modified, 
    # change frequency (optional), and priority.
    #
    # Returns url REXML::Element
    def fill_url(site, page_or_post)
      url = REXML::Element.new "url"

      loc = fill_location(page_or_post)
      url.add_element(loc)

      lastmod = fill_last_modified(site, page_or_post)
      url.add_element(lastmod) if lastmod

      if (page_or_post.data[CHANGE_FREQUENCY_CUSTOM_VARIABLE_NAME])
        change_frequency = 
          page_or_post.data[CHANGE_FREQUENCY_CUSTOM_VARIABLE_NAME].downcase

        if (valid_change_frequency?(change_frequency))
          changefreq = REXML::Element.new "changefreq"
          changefreq.text = change_frequency
          url.add_element(changefreq)
        else
          puts "ERROR: Invalid Change Frequency In #{page_or_post.name}"
        end
      end

      if (page_or_post.data[PRIORITY_CUSTOM_VARIABLE_NAME])
        priority_value = page_or_post.data[PRIORITY_CUSTOM_VARIABLE_NAME]
        if valid_priority?(priority_value)
          priority = REXML::Element.new "priority"
          priority.text = page_or_post.data[PRIORITY_CUSTOM_VARIABLE_NAME]
          url.add_element(priority)
        else
          puts "ERROR: Invalid Priority In #{page_or_post.name}"
        end
      end

      url
    end

    # Get URL location of page or post 
    #
    # Returns the location of the page or post
    def fill_location(page_or_post)
      loc = REXML::Element.new "loc"
      loc.text = page_or_post.location_on_server

      loc
    end

    # Fill lastmod XML element with the last modified date for the page or post.
    #
    # Returns lastmod REXML::Element or nil
    def fill_last_modified(site, page_or_post)
      path = page_or_post.full_path_to_source

      lastmod = REXML::Element.new "lastmod"
      date = File.mtime(path)
      latest_date = find_latest_date(date, site, page_or_post)

      if @last_modified_post_date == nil
        # This is a post
        lastmod.text = latest_date.iso8601
      else
        # This is a page
        if posts_included?(page_or_post.name)
          # We want to take into account the last post date
          final_date = greater_date(latest_date, @last_modified_post_date)
          lastmod.text = final_date.iso8601
        else
          lastmod.text = latest_date.iso8601
        end
      end
      lastmod
    end

    # Go through the page/post and any implemented layouts and get the latest
    # modified date
    #
    # Returns formatted output of latest date of page/post and any used layouts
    def find_latest_date(latest_date, site, page_or_post)
      layouts = site.layouts
      layout = layouts[page_or_post.data["layout"]]
      while layout
        path = layout.full_path_to_source
        date = File.mtime(path)

        latest_date = date if (date > latest_date)

        layout = layouts[layout.data["layout"]]
      end

      latest_date
    end

    # Which of the two dates is later
    #
    # Returns latest of two dates
    def greater_date(date1, date2)
      if (date1 >= date2) 
        date1
      else 
        date2 
      end
    end

    # Is the page or post listed as something we want to exclude?
    #
    # Returns boolean
    def excluded?(name)
      EXCLUDED_FILES.include? name
    end

    def posts_included?(name)
      PAGES_INCLUDE_POSTS.include? name
    end

    # Is the change frequency value provided valid according to the spec
    #
    # Returns boolean
    def valid_change_frequency?(change_frequency)
      VALID_CHANGE_FREQUENCY_VALUES.include? change_frequency
    end

    # Is the priority value provided valid according to the spec
    #
    # Returns boolean
    def valid_priority?(priority)
      begin
        priority_val = Float(priority)
        return true if priority_val >= 0.0 and priority_val <= 1.0
      rescue ArgumentError
      end

      false
    end
  end
end