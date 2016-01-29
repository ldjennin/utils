# Various Drupal specific command lines.

# Remove Drupal imagecache files that have not been accessed in 90 days
sudo find /web/*/htdocs/sites/default/files/imagecache/. -atime +90 -ls -delete
