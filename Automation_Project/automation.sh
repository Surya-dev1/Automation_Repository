sudo apt update -y

Check_apache_installation="apache2 -v 2>/dev/null"
Install_apache="sudo apt install apache2"
LOGS="/var/log/apache2/install.log"

if $Check_apache_intallation
then
$Install_apache
echo "=====Version======"
apache2 -v
echo "=====Apache is Installed====="
fi

sudo systemctl enable apache2

start_apache="systemctl start apache2"
check="systemctl status apache2 |grep active"

if systemctl status apache2 | grep inactive
then
echo "====== $(date) ======"
echo "Starting Apache..."
$start_apache
echo "Apache is Running"
else
$check
echo "====== $(date) ======"
        echo "Apache is running"
fi

myname="Surya"
s3_bucket="upgrad-surya"
timestamp=$(date '+%d%m%Y-%H%M%S')

cd /var/log/apache2/;tar -cvf ${myname}_httpd-logs_${timestamp}.tar error.log access.log;chmod 755 ${myname}_httpd-logs_${timestamp}.tar ;
cp ${myname}_httpd-logs_${timestamp}.tar error.log access.log /tmp;cd /tmp;ls -lrt

aws s3 cp /tmp/ s3://${s3_bucket}/ --recursive --exclude "*.log"
