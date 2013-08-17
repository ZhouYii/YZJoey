# Run Jekyll
echo "-> Running Jekyll"
sudo jekyll

# Upload to S3!
echo "\n\n-> Uploading to S3"


# Sync media files first (Cache: expire in 10weeks)
echo "\n--> Syncing media files..."
s3cmd sync --acl-public --exclude '*.*' --include '*.png' --include '*.jpg' --include '*.ico' --add-header="Expires: Sat, 20 Nov 2020 18:46:39 GMT" --add-header="Cache-Control: max-age=6048000"  _site/ s3://www.yzjoey.com/

# Sync Javascript and CSS assets next (Cache: expire in 1 week)
echo "\n--> Syncing .js and .css files..."
s3cmd sync --acl-public --exclude '*.*' --include  '*.css' --include '*.js' --add-header="Cache-Control: max-age=604800"  _site/ s3://www.yzjoey.com

# Sync html files (Cache: 2 hours)
echo "\n--> Syncing .html"
s3cmd sync --acl-public --exclude '*.*' --include  '*.html' --add-header="Cache-Control: max-age=7200, must-revalidate"  _site/ s3://www.yzjoey.com

# Sync everything else, but ignore the assets!
echo "\n--> Syncing everything else"
s3cmd sync --acl-public --exclude '.un~' --exclude 'assets/'  _site/ s3://www.yzjoey.com/

# Sync: remaining files & delete removed
s3cmd sync --acl-public --delete-removed  _site/ s3://www.yzjoey.com/



# Sync media files first (Cache: expire in 10weeks)
echo "\n--> Syncing media files..."
s3cmd sync --acl-public --exclude '*.*' --include '*.png' --include '*.jpg' --include '*.ico' --add-header="Expires: Sat, 20 Nov 2020 18:46:39 GMT" --add-header="Cache-Control: max-age=6048000"  _site/ s3://www.joeytime.com/

# Sync Javascript and CSS assets next (Cache: expire in 1 week)
echo "\n--> Syncing .js and .css files..."
s3cmd sync --acl-public --exclude '*.*' --include  '*.css' --include '*.js' --add-header="Cache-Control: max-age=604800"  _site/ s3://www.joeytime.com

# Sync html files (Cache: 2 hours)
echo "\n--> Syncing .html"
s3cmd sync --acl-public --exclude '*.*' --include  '*.html' --add-header="Cache-Control: max-age=7200, must-revalidate"  _site/ s3://www.joeytime.com

# Sync everything else, but ignore the assets!
echo "\n--> Syncing everything else"
s3cmd sync --acl-public --exclude '.un~' --exclude 'assets/'  _site/ s3://www.joeytime.com/

# Sync: remaining files & delete removed
s3cmd sync --acl-public --delete-removed  _site/ s3://www.joeytime.com/



# Sync media files first (Cache: expire in 10weeks)
echo "\n--> Syncing media files..."
s3cmd sync --acl-public --exclude '*.*' --include '*.png' --include '*.jpg' --include '*.ico' --add-header="Expires: Sat, 20 Nov 2020 18:46:39 GMT" --add-header="Cache-Control: max-age=6048000"  _site/ s3://joeytime.com/

# Sync Javascript and CSS assets next (Cache: expire in 1 week)
echo "\n--> Syncing .js and .css files..."
s3cmd sync --acl-public --exclude '*.*' --include  '*.css' --include '*.js' --add-header="Cache-Control: max-age=604800"  _site/ s3://joeytime.com

# Sync html files (Cache: 2 hours)
echo "\n--> Syncing .html"
s3cmd sync --acl-public --exclude '*.*' --include  '*.html' --add-header="Cache-Control: max-age=7200, must-revalidate"  _site/ s3://joeytime.com

# Sync everything else, but ignore the assets!
echo "\n--> Syncing everything else"
s3cmd sync --acl-public --exclude '.un~' --exclude 'assets/'  _site/ s3://joeytime.com/

# Sync: remaining files & delete removed
s3cmd sync --acl-public --delete-removed  _site/ s3://joeytime.com/
