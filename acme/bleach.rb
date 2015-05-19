def whiten c;c.unpack('b*')[0].tr '01'," \t";end
def brighten c;[c.tr(" \t",'01')].pack 'b*';end
# Perlの source filter らしきものをデモする爲に __END__ を使った。
# __END__ 以降が文法的なRubyだと前提する場合は当然 __END__ は要らない。__END__ が無ければ DATA.path が無くなるので $0 を使ふ。
# 因みにPerlのAcme::Bleachは source filter とは関係ない。今回のRubyに就いても関係ない。飽くまでデモの爲である。
f=DATA
fn=f.path
d=f.read
if d=~/\A[ \t]*\z/
  eval brighten d
else
  require 'fileutils'
  FileUtils.cp fn,fn+'.bak'
  f.rewind
  c=f.read.split(/^(__END__\n)/,2).tap{|c|break(c[0..1]<< whiten(c[2])).join}
  open(fn,'w:utf-8'){|f|f.write c}
end
