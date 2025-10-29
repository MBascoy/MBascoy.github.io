#!/bin/bash

SITEMAP_FILE="sitemap.xml"

WEBSITE="https://mbascoy.pages.dev/"
WEBSITE_FOLDER="./knowledge"

echo '<?xml version="1.0" encoding="UTF-8"?>' > $SITEMAP_FILE
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">' >> $SITEMAP_FILE

find $WEBSITE_FOLDER -type f -not -path "./.git/*" -printf "%TY-%Tm-%Td**%p\n" | awk -F "**" -v website=$WEBSITE '{ printf "\t<url>\n\t\t<loc>%s%s</loc>\n\t\t<lastmod>%s</lastmod>\n\t\t<changefreq>monthly</changefreq>\n\t</url>\n", website, substr($2,3), $1 }' >> $SITEMAP_FILE

echo "</urlset>" >> $SITEMAP_FILE
