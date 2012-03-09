#!/usr/bin/perl
use strict;
use Data::Dumper;

#use Chart::Plot;
use GD::Graph;

my $img = Chart::Plot->new(1024, 768);

my $inputFile = $ARGV[0];
my %data = loadData($inputFile);

#print Dumper(%data);
my @yMEM = @{$data{mem}};
my $arraySize = $#yMEM + 1;
my @xAxis = (1..$arraySize);

my @yCPU = @{$data{cpu}};
my @yLOAD = @{$data{load}};
my @yFH = @{$data{fh}};

#my @yanotherdataset = qw (6 1 2 6 8 1 5 7);

#my $anotherImg = Chart::Plot->new ($image_width, $image_height); 
    
#$img->setData (\@dataset) or die( $img->error() );
#$img->setData (\@xdataset, \@ydataset);
$img->setData (\@xAxis, \@yMEM, 'Blue SolidLine NoPoints');
$img->setData (\@xAxis, \@yCPU, 'Red SolidLine NoPoints');
$img->setData (\@xAxis, \@yLOAD, 'Green SolidLine NoPoints');
$img->setData (\@xAxis, \@yFH, 'BLACK SolidLine NoPoints');
#$img->setData (\@yanotherdataset, 'Blue SolidLine NoPoints');
    
my ($xmin, $ymin, $xmax, $ymax) = $img->getBounds();
    
#$img->setGraphOptions ('horGraphOffset' => 75,                            
#'vertGraphOffset' => 2000,                            
#'title' => 'My Graph Title',                            
#'horAxisLabel' => 'my X label',                            
#'vertAxisLabel' => 'my Y label' 
#);

my $GDobject = $img->getGDobject();
my $white = $GDobject->colorAllocate(255,255,255);
$GDobject->fill(50,50,$white);

my $image = $inputFile;
$image =~ s/.*\///g;

    $img->setGraphOptions ('title' => $image);

open (FH, "> $image.png");    
binmode FH;
print FH $img->draw();
close FH;



sub loadData {
	my $file = shift;
	my %data = ();
	
	open (IN, "<$file");
	while (<IN>) {
		my ($date, $load, $pid, $mem, $cpu, $fh) = split(/,/, $_);
		$mem =~ s/M//;
		
		chop $cpu;
		chop $mem;
		chomp $fh;
		$mem = $mem / 10;
		$load = $load * 100;
		$cpu = $cpu * 100;
		
		push(@{$data{date}}, $date);
		push(@{$data{load}}, $load);
		push(@{$data{pid}}, $pid);
		push(@{$data{mem}}, $mem);
		push(@{$data{cpu}}, $cpu);
		push(@{$data{fh}}, $fh);
		
	}
	return %data;
}
		