#!/usr/bin/perl

use strict;
use Spreadsheet::ParseExcel;
use Spreadsheet::WriteExcel;
use Data::Dumper;
use Date::Calc qw(Month_to_Text Delta_Days);

die "You must provide a filename to $0 to be parsed as an Excel file" unless @ARGV;

my $outFile = 'conversion-'.$ARGV[0];
my $oBook = openSpreadsheet($ARGV[0]);
my %taskHash = buildTaskHash($oBook);
my %pbiHash = buildPBIHash($oBook);
#print Dumper(%taskHash);

my $bcBook = Spreadsheet::WriteExcel->new($outFile);
my $bcWkS = $bcBook->add_worksheet();
$bcWkS = doFirstRow($bcWkS);
#buildSpreadsheet($outFile);
#printSheet('Impediments');
#processAllSheets($oBook);

my $PBIWkS = $oBook->worksheet('PBI');
my $PBIRowCount = $PBIWkS->{MaxRow};
#print "PBI Row Count: $PBIRowCount\n";

my $totalRowCount;
for (my $i = 1; $i <= $PBIRowCount; $i++) {
	my $PBIid = $PBIWkS->get_cell($i, 12)->value();
	my $PBIRow = $PBIWkS->get_cell($i, 0)->value();
	#my $PBIStartDate = $PBIWkS->get_cell($i, 9)->value();
	#print Dumper(%taskHash);
	
	my $taskCount = 0;
	foreach my $task (@{$taskHash{$PBIid}}) {
		my %tHash = %{$task};
		#print "Task Dump: \n";
		#print $tHash{pid}."\n";
		#print $tHash{name}."\n";
		#print $tHash{tid}."\n";
		#print $tHash{sid}."\n";
		my $dayPercentage = ($tHash{estimatedHours}/24);
		$dayPercentage =  sprintf("%.2f", $dayPercentage);
		
		my ($bMonth, $bDay, $bYear) = split(/\//, $tHash{sprintBeginDate});
		my ($eMonth, $eDay, $eYear) = split(/\//, $tHash{sprintEndDate});
		
		my $Dd = "";
		my $bTextMonth = "";
		
		#print $tHash{sprintBeginDate}."\n";
		#print $tHash{sprintEndDate}."\n";
		if($bMonth =~ m/./ && $eMonth !~ m/1900/ && $eMonth =~ m/./ && $eMonth !~ m/1900/) {
			print "bMonth: ".$bMonth."\n";
			$bTextMonth = Month_to_Text($bMonth, 1);
			$Dd = Delta_Days($bYear,$bMonth,$bDay,
                       $eYear,$eMonth, $eDay);
        } else {
			#print "Problem with dates:\n";
			#print "\tBegin: $tHash{sprintBeginDate}\n";
			#print "\tEnd: $tHash{sprintEndDate}\n";
		}
		
		$bcWkS->write_string($totalRowCount, 0, $PBIRow);
		$bcWkS->write_string($totalRowCount, 1, 'N/A');
		$bcWkS->write_string($totalRowCount, 2, 'N/A');
		$bcWkS->write_string($totalRowCount, 3, $PBIRow);
		$bcWkS->write_string($totalRowCount, 4, $PBIWkS->get_cell($i, 1)->value());
		$bcWkS->write_string($totalRowCount, 5, $PBIRow.'.'.$taskCount);
		$bcWkS->write_string($totalRowCount, 6, $tHash{name});
		$bcWkS->write_string($totalRowCount, 7, 'Yes');
		$bcWkS->write_string($totalRowCount, 8, 'Automated FLEX component testing using QTP testing software');
		$bcWkS->write_string($totalRowCount, 9, 'Code written, tested on workstation, checked into build, deployed to dev. server, tested by QTP automated test cases.');
		$bcWkS->write_string($totalRowCount, 10, 'N/A');
		$bcWkS->write_string($totalRowCount, 11, $tHash{sprintBeginDate});
		$bcWkS->write_string($totalRowCount, 12, "$dayPercentage days remaining");
		$bcWkS->write_string($totalRowCount, 13, 'Lynx');
		$bcWkS->write_string($totalRowCount, 14, 'Becky Beasley');
		$bcWkS->write_string($totalRowCount, 15, 'Kevin Cropp');
		$bcWkS->write_string($totalRowCount, 16, $tHash{teamname});
		$bcWkS->write_string($totalRowCount, 17, $tHash{status});
		$bcWkS->write_string($totalRowCount, 18, 'N/A');
		$bcWkS->write_string($totalRowCount, 19, 'Felicia Ware-Joyner');
		$bcWkS->write_string($totalRowCount, 20, 'N/A');
		
		
		$totalRowCount++;
		$taskCount++;
	}
	#$totalRowCount++;
}
$bcBook->close();

processAllSheets(openSpreadsheet($outFile));

print "Final file: $outFile\n";


 #####################################################################
############################### METHODS ###############################
 #####################################################################

sub doFirstRow() {
	my $oBook = shift;
	$oBook->write_string(0, 0, 'Product Backlog ID#');
	$oBook->write_string(0, 1, 'Priority #');
	$oBook->write_string(0, 2, 'Project EPAS#');
	$oBook->write_string(0, 3, 'User Story or BREQ #');
	$oBook->write_string(0, 4, 'User Story (high level) or BREQ Description');
	$oBook->write_string(0, 5, 'User Story or SREQ #');
	$oBook->write_string(0, 6, 'User Story (detail level) or SREQ Description');
	$oBook->write_string(0, 7, 'Sprintable (Y/N)?');
	$oBook->write_string(0, 8, 'Acceptance Criteria');
	$oBook->write_string(0, 9, 'Definition of DONE');
	$oBook->write_string(0, 10, 'Corporate Release');
	$oBook->write_string(0, 11, 'Sprint Month');
	$oBook->write_string(0, 12, 'Est. Story Days');
	$oBook->write_string(0, 13, 'Impacted Systems');
	$oBook->write_string(0, 14, 'Product Owner');
	$oBook->write_string(0, 15, 'Scrum Master');
	$oBook->write_string(0, 16, 'Scrum Team');
	$oBook->write_string(0, 17, 'Status');
	$oBook->write_string(0, 18, 'Date PB Item Added');
	$oBook->write_string(0, 19, 'PB Source (BA Name)');
	$oBook->write_string(0, 20, 'Funding Available (Y/N)?');

	return $oBook;
}

sub  buildPBIHash() {
	#print "Build PBI Hash\n";
	my $oBook = shift;
	my %PBIHash = ();
	
	my $oWkS = $oBook->worksheet('PBI Estimates');
	
	for (my $i = 1; $i < $oWkS->{MaxRow}; $i++) {
		#print $i." ";
		my %pbi = ();
		my $PBIEstimate = $oWkS->get_cell($i, 3)
			if defined($oWkS->get_cell($i, 3)->value());
		my $PBIid = $oWkS->get_cell($i, 4)
			if defined($oWkS->get_cell($i, 4)->value());
				
		if($PBIEstimate > $pbi{estimate}) {
				$pbi{estimate} = $PBIEstimate;
		}
		
		$pbi{id} = $PBIid;
		$PBIHash{$PBIid} = \%pbi;
		
	}
	print "PBI Hash Built\n";
	return %PBIHash;
}

sub buildTaskHash() {
	print "Build Task Hash\n";
	my $oBook = shift;
	my $taskHash = ();

	my $oWkS = $oBook->worksheet('Tasks');
		
	for (my $i = 1; $i < $oWkS->{MaxRow}; $i++) {
		my %task = ();
		print "$i ";
		print "a";
		my $estimatedHours = $oWkS->get_cell($i, 5)->value()
			if defined ($oWkS->get_cell($i, 5));
		my $pid = $oWkS->get_cell($i, 16)->value()
			if defined ($oWkS->get_cell($i, 16));
		print "b";	
		my $name = $oWkS->get_cell($i, 1)->value()
			if defined ($oWkS->get_cell($i, 1));
		print "c";	
		my $tid = $oWkS->get_cell($i, 19)->value()
			if defined ($oWkS->get_cell($i, 19));
		print "d";	
		my $sid = $oWkS->get_cell($i, 17)->value()
			if defined ($oWkS->get_cell($i, 17));
		print "e";	
		my $active = $oWkS->get_cell($i, 9)->value()
			if defined ($oWkS->get_cell($i, 9));
		print "f";	
		my $complete = $oWkS->get_cell($i, 10)->value()
			if defined ($oWkS->get_cell($i, 10));
		print "g";	
		my $pointPerson = $oWkS->get_cell($i, 3)->value()
			if defined ($oWkS->get_cell($i, 3));
		print "h";	
		my $sprintBeginDate = $oWkS->get_cell($i, 13)->value()
			if defined ($oWkS->get_cell($i, 13));
		print "i";	
		my $sprintEndDate = $oWkS->get_cell($i, 14)->value()
			if defined($oWkS->get_cell($i, 14));
		print "j";	
		my $teamName = $oWkS->get_cell($i, 15)->value()
			if defined($oWkS->get_cell($i, 15));
		print "\n";
		my $status = $oWkS->get_cell($i, 4)->value()
			if defined($oWkS->get_cell($i, 4));
			
			
			
		if($complete =~ m/Yes/) { 
				$task{status} = "Complete";
		} elsif ($active =~ m/Yes/) {
				$task{status} = "In Progress";
		} else {
				$task{status} = "Not Started";
		}
		
		$task{status} = $status;
		$task{person} = $pointPerson;
		$task{pid} = $pid;
		$task{name} = $name;
		$task{tid} = $tid;
		$task{sid} = $sid;
		print "Entering dates: $sprintBeginDate - $sprintEndDate\n";
		$task{sprintBeginDate} = $sprintBeginDate;
		$task{sprintEndDate} = $sprintEndDate;
		$task{teamname} = $teamName;
		$task{estimatedHours} = $estimatedHours;
		
		push (@{$taskHash{$pid}}, \%task);
	}
	print "Hash is built\n";
	
	return %taskHash;
}

sub buildSpreadsheet() {
	my $workbook = Spreadsheet::WriteExcel->new($_[0]);
	my $worksheet = $workbook->add_worksheet();

	my $rowCount = 0;
	while ($rowCount < 5) {
		$worksheet->write_string($rowCount, 0, 'N/A');
		$worksheet->write_string($rowCount, 1, 'N/A');
		$worksheet->write_string($rowCount, 3, 'N/A');
		$worksheet->write_string($rowCount, 4, '???');
		$rowCount++;
	}
}

sub openSpreadsheet() {
	my $oExcel = new Spreadsheet::ParseExcel;
	my $file = shift;
	my $oBook = $oExcel->Parse($file);
	my($iR, $iC, $oWkS, $oWkC);
	print "FILE  :", $oBook->{File} , "\n";
	print "COUNT :", $oBook->{SheetCount} , "\n";

	if (defined $oBook->{Author}) {
		print "AUTHOR:", $oBook->{Author} , "\n" 
	}
	return $oBook;
}

sub printSheet() {
 my $oSheetName = shift;
 my($iR, $iC, $oWkS, $oWkC);
 $oWkS = $oBook->worksheet($oSheetName);
 print "--------- SHEET:", $oWkS->{Name}, "\n";
 for(my $iR = $oWkS->{MinRow} ;
     defined $oWkS->{MaxRow} && $iR <= $oWkS->{MaxRow} ;
     $iR++)
 {
  for(my $iC = $oWkS->{MinCol} ;
      defined $oWkS->{MaxCol} && $iC <= $oWkS->{MaxCol} ;
      $iC++)
  {
   $oWkC = $oWkS->{Cells}[$iR][$iC];
   print "( $iR , $iC ) =>", $oWkC->Value, "\n" if($oWkC);
  }
 }
}
 
sub processAllSheets() {
my $oBook = shift;
my($iR, $iC, $oWkS, $oWkC);

for(my $iSheet=0; $iSheet < $oBook->{SheetCount} ; $iSheet++)
{
 $oWkS = $oBook->{Worksheet}[$iSheet];
 print "--------- SHEET:", $oWkS->{Name}, "\n";
 for(my $iR = $oWkS->{MinRow} ;
     defined $oWkS->{MaxRow} && $iR <= $oWkS->{MaxRow} ;
     $iR++)
 {
  for(my $iC = $oWkS->{MinCol} ;
      defined $oWkS->{MaxCol} && $iC <= $oWkS->{MaxCol} ;
      $iC++)
  {
   $oWkC = $oWkS->{Cells}[$iR][$iC];
   print "( $iR , $iC ) =>", $oWkC->Value, "\n" if($oWkC);
  }
 }
}
}
