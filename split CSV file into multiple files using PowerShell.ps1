# Adapted from https://www.codetwo.com/admins-blog/how-to-split-csv-file-into-multiple-files-using-powershell/

# variable used to store the path of the source CSV file
$sourceCSV = "C:\enter\csv\file\location\here.csv";

# Create export folder
$exportFolder = "C:\enter\export\folder\location\here";

# Create export folder if it doesn't exist
If (!(test-path $exportFolder)) {
    New-Item -ItemType Directory -Force -Path $exportFolder;
}

# Import CSV
$csv = Import-CSV $sourceCSV;
$csvLength = $csv.Length;

# View imported CSV [debugging]
# $csv | Select-Object -First 10 | Format-Table;

# variable used to advance the number of the row from which the export starts
$startrow = 0;

# counter used in names of resulting CSV files
$counter = 1;

# Split csv by this many rows, modify to whatever number you want the CSV to split on
$splitValue = 2999;

# setting the while loop to continue as long as the value of the $startrow variable is smaller than the number of rows in your source CSV file
while ($startrow -lt $csvLength) {

    # import of however many rows you want the resulting CSV to contain starting from the $startrow position and export of the imported content to a new file
    $csv | select-object -skip $startrow -first $splitValue | Export-CSV "$($exportFolder)\$($counter).csv" -NoTypeInformation;

    # advancing the number of the row from which the export starts
    $startrow += $splitValue;

    # incrementing the $counter variable
    $counter++;
}
