#! /usr/bin/perl
#
# luhn.pl - Luhn algorithm test program (Perl4 or Perl5)
#

sub check_number {
    local($number) = @_;
    local($i, $sum, $ch, $num, $twoup, $len);

    $len = length($number);
    $sum = 0;
    $twoup = 0;
    for ($i = $len - 1; $i >= 0; --$i) {
        $ch = substr($number, $i, 1);
        $num = unpack('c', $ch) - 0x30;
        $num += $num if ($twoup);
        $num = int($num / 10) + ($num % 10) if ($num > 9);
        $sum += $num;
        $twoup = (++$twoup) & 1;
    }
    $sum = 10 - ($sum % 10);
    $sum = 0 if ($sum == 10);
    return ($sum == 0) ? 1 : 0;
}

sub calc_digit {
    local($number) = @_;
    local($i, $sum, $ch, $num, $twoup, $len);

    $len = length($number);
    $sum = 0;
    $twoup = 1;
    for ($i = $len - 1; $i >= 0; --$i) {
        $ch = substr($number, $i, 1);
        $num = unpack('c', $ch) - 0x30;
        $num += $num if ($twoup);
        $num = int($num / 10) + ($num % 10) if ($num > 9);
        $sum += $num;
        $twoup = (++$twoup) & 1;
    }
    $sum = 10 - ($sum % 10);
    $sum = 0 if ($sum == 10);
    return $sum;
}

if ($ARGV[0] eq '') {
    print STDERR "usage: perl $0 number ...\n";
    exit(1);
}
while ($ARGV[0] ne '') {
    $number = $ARGV[0]; shift;
    $ok = &check_number($number);
    $check_digit = &calc_digit($number);
    printf("$number %s check\n", ($ok) ? "passes" : "fails");
    print "$number needs check-digit '$check_digit'\n";
}
exit 0;
