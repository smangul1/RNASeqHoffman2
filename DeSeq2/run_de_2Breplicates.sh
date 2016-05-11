if [ $# -lt 2 ]
then
echo "[1] - conditions"
echo "[2] - dir with counts"
exit 1
fi

dir=$2
cd $dir


while read line1
do

while read line2
do

if [ "$line1" != "$line2" ]
then
echo $line1"	"$line2

mkdir ${line1}_${line2}
cd ${line1}_${line2}
ln -s ${2}/*${line1}*counts ./
ln -s ${2}/*${line2}*counts ./

echo "Rscript ~/code/DE/de.R ${dir}/${line1}_${line2}/ $line1 $line2"
Rscript ~/code/DE/de_C1_C1_C2_C2.R ${dir}/${line1}_${line2}/ $line1 $line2

ls -l
pwd
cd ..



fi

done<$1

done<$1
