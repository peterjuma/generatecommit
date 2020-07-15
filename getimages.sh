# get all pages
curl 'http://domain.com/id/[1-151468]' -o '#1.html'

# get all images
grep -oh 'http://pics.domain.com/pics/original/.*jpg' *.html >urls.txt

# download all images
sort -u urls.txt | wget -i-
