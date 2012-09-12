#!/usr/bin/perl
# url of the generated file
$MY_RSSFILE="http://homeweb.sullust.org/tk/rss.rdf";
# physical location
$MY_FILE="./rss.rdf";
# title
$MY_TITLE="Tony Kornheiser";
# description
$MY_DESC="";
# where is the site
$MY_LINK="http://homeweb.sullust.org/tk/";
# your logo or other image
$MY_IMAGE="";
$MY_IMAGE_TITLE="";
# local storage for page info
$MY_STORED_DATA="./storeit";
# how many items to generate.
# you can make it larger, but some readers will only show 15, and you
# do need to stop somewhere.
$MAX=15;
getnew();
open(O,">$MY_FILE") or die "How come $! $MY_FILE ?";
$now=time;
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime($now);
@month=("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
$year += 1900;
@days=("Sun","Mon","Tue","Wed","Thu","Fri","Sat");
$AM="AM";
$AM="PM" if $hour > 12;
$hms=sprintf("%.2d:%.2d:%.2d",$hour,$min,$sec);
$update="$days[$wday], $mday $month[$mon] $year $hms GMT";
print O <<EOF;
<?xml version="1.0" encoding="iso-8859-1"?>
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:dc="http://purl.org/dc/elements/1.1/"
xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
xmlns:admin="http://webns.net/mvcb/"
xmlns="http://purl.org/rss/1.0/">
<channel rdf:about="$MY_RSSFILE">
<title>$MY_TITLE</title>
<description>
$MY_DESC
</description>
<dc:language>en</dc:language>
<link>$MY_LINK</link>
<lastBuildDate>$update</lastBuildDate>
<image rdf:resource="$MY_IMAGE">
</image>
<items>
<rdf:Seq>
EOF
for ($x=0;$x < 15;$x++) {
last if not $url[$x];
print O <<EOF;
<rdf:li rdf:resource="$url[$x]" />
EOF
}

print O  <<EOF;
</rdf:Seq>
</items>
</channel>
<image rdf:about="$MY_IMAGE">
<title>$MY_IMAGE_TITLE</title>
<url>$MY_IMAGE</url>
<link>$MY_LINK</link>
</image>


EOF
for ($x=0; $x < 15 ; $x++) {
last if not $url[$x];
print O <<EOF;
<item rdf:about="$url[$x]">
<title>$stuff[$x]</title>
<description>$desc[$x]</description>
<link>$url[$x]</link>
</item>
EOF
}
print O "</rdf:RDF>\n";
close O;

sub getnew {

print <<EOF;
Add new information; CTRL-D when done.
Enter: url|title|description
Example
http://yourweb.com/cows.html|Cows of New Jersey|Examining the cow breeds of New Jersey farms
EOF
$x=0;
open(FH, "< $ARGV[0]");
open(O,">>$MY_STORED_DATA") or die "Hey $! $MY_STORED_DATA";
while (<FH>) {
  last if $x == $MAX;
  print O $_;
  $x++;
}
close O;
open(O,"$MY_STORED_DATA") or die "Huh? $! $MY_STORED_DATA";
@webpage=<O>;close O;
$xcnt=0;
foreach (reverse @webpage) {
  last if $xcnt == $MAX ;
  chomp;
  ($link,$title,$desc)=split /\|/;
  $stuff[$xcnt]=$title;
  $desc[$xcnt]=$desc;
  $url[$xcnt++]=$link;
}
}