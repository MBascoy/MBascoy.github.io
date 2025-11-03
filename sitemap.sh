#!/bin/bash

SITEMAP_FILE="sitemap.xml"

WEBSITE="https://mbascoy.dev/"
WEBSITE_FOLDER=""

echo '<?xml version="1.0" encoding="UTF-8"?>' > $SITEMAP_FILE
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">' >> $SITEMAP_FILE

#find command to find all files inside WEBSITE_FOLDER, ignoring some folders and files, after that it pipes to awk command to generate the xml structure with all the files found.
find $WEBSITE_FOLDER \
-type f \
-not -path "./.git/*" \
-not -name "google8ad719b3a8ef55f1.html" \
-not -name "sitemap.sh" \
-not -name "sitemap.xml" \
-not -name "robots.txt" \
-printf "%TY-%Tm-%Td**%p\n" | \
awk -F "**" \
-v website=$WEBSITE \
'{ printf "\
\t<url>\n\
\t\t<loc>%s%s</loc>\n\
\t\t<lastmod>%s</lastmod>\n\
\t\t<changefreq>monthly</changefreq>\n\
\t</url>\n\
", website, substr($2,3), $1 }' >> $SITEMAP_FILE

echo "</urlset>" >> $SITEMAP_FILE
