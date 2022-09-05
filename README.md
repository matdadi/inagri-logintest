# inagri-logintest
Dadi Rahmat

# run windows
git clone https://github.com/matdadi/inagri-logintest.git
py -m venv env
env\scripts\activate.bat
pip install flask mysql-connector-python
cd inagri-logintest
set FLASK_APP=dadi-submission
set FLASK_DEBUG=1
flask run

# user
username: admin
password: inagri1234.

# database
dump-dadi-submission-202209031540.sql
