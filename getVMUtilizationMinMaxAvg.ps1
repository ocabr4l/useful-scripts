$allvms = @()
$allhosts = @()
$vms = Get-Vm

foreach($vm in $vms){
  $vmstat = "" | Select VmName, MemMax, MemAvg, MemMin, CPUMax, CPUAvg, CPUMin
  $vmstat.VmName = $vm.name
  
  $statcpu = Get-Stat -Entity ($vm)-start (get-date).AddDays(-30) -Finish (Get-Date)-MaxSamples 10000 -stat cpu.usage.average
  $statmem = Get-Stat -Entity ($vm)-start (get-date).AddDays(-30) -Finish (Get-Date)-MaxSamples 10000 -stat mem.usage.average

  $cpu = $statcpu | Measure-Object -Property value -Average -Maximum -Minimum
  $mem = $statmem | Measure-Object -Property value -Average -Maximum -Minimum
  
  $vmstat.CPUMax = $cpu.Maximum
  $vmstat.CPUAvg = $cpu.Average
  $vmstat.CPUMin = $cpu.Minimum
  $vmstat.MemMax = $mem.Maximum
  $vmstat.MemAvg = $mem.Average
  $vmstat.MemMin = $mem.Minimum
  $allvms += $vmstat
}
$allvms | Select VmName, MemMax, MemAvg, MemMin, CPUMax, CPUAvg, CPUMin | Export-Csv "c:\VMs.csv" -noTypeInformation
