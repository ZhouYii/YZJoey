---
layout: blog_post
title: Setting Up This Site
excerpt: This site was the result of an experiment looking at indefinitely sustainable website hosting. So far Jekyll and Amazon S3 show no signs of dying out and neither does this site.
---
<p class="intro">
Sustainability is something I consided before taking the time to build this site. Almost everything has some sort of cost associated with it and making a quick website is no different. At first, I thought maybe this website is something that will briefly hold my interest before quickly falling into disuse. Luckily for me, Jekyll and Amazon's S3 online storage service provides me a way to host my site without dealing with server hosts. In terms of costs, the sunk cost to acquire a domain was small and there are no visible recurring costs for at least a year.
<br><br>
A lot of code on this blog was forked from a similar blog made by Allan Pope. His github is here: https://github.com/allanpope. I stripped down the website even more to push the minimalist motif to the limits. This involved fiddling with a certain Snap.js library because even after I deleted the library file, the javascript code was still being called and was modifying my page elements. After half a hour of aggravation, I realized there was a library file with the Snap.js library concatenated at it's end. Such is the cost of standing on the shoulders of fantastic frontend developers.</p>
