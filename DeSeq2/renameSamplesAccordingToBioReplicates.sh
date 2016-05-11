while read line 
do
x=$(echo $line | awk -F "_" '{print $1}')
y=$(echo $line | awk -F "_" '{print $2}')

echo $x"	"$y
mv Sample-${x}_S${x}_L00*_R1_001.counts.clean ${x}_${y}_Sample-${x}_S${x}_L00*_R1_001.counts.clean
mv Sample-${y}_S${y}_L00*_R1_001.counts.clean ${x}_${y}_Sample-${y}_S${y}_L00*_R1_001.counts.clean

done<$1
