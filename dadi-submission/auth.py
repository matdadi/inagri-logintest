from urllib import request
from functools import wraps
from flask import Blueprint, render_template, redirect, url_for, flash, request, session
from werkzeug.security import generate_password_hash, check_password_hash
from .database import db
import re

auth = Blueprint('auth', __name__)

@auth.route('/login')
def login():
    return render_template('login.html')

@auth.route('/login', methods=['POST'])
def login_post():
    session.pop('_flashes', None)
    # login
    username = request.form.get('username')
    password = request.form.get('password')
    remember = True if request.form.get('remember') else False

    cursor = db.cursor()
    adr = (username,)
    quer = "SELECT user.* FROM user WHERE user.Username=%s"
    cursor.execute(quer, adr)
    user = cursor.fetchone()

    # check if user is exist
    # check the hashed password
    if not user or not check_password_hash(user[4], password):
        flash('Please check your login details and try again.')
        return redirect(url_for('auth.login'))

    if user[9]==0:
        flash('Your user account is blocked!')
        return redirect(url_for('auth.login'))

    session['loggedin'] = True
    session['id'] = user[0]
    session['username'] = user[1]
    session['remember'] = remember

    cursor.close()

    return redirect(url_for('main.profile'))

@auth.route('/signup')
def signup():
    cursor = db.cursor()
    cursor.execute("SELECT roles.* FROM roles")
    roles = cursor.fetchall()

    cursor.execute("SELECT subgrups.Id, subgrups.Nama, grups.Nama FROM subgrups LEFT JOIN grups ON (subgrups.GrupId=grups.Id)")
    subgrups = cursor.fetchall()

    # cursor.close()
    return render_template('signup.html', roles=roles, subgrups=subgrups)
    # return render_template('signup.html')

@auth.route('/signup', methods=['POST'])
def signup_post():
    session.pop('_flashes', None)
    # validate and add user to db
    username = request.form.get('username')
    password = generate_password_hash(request.form.get('password'), method='sha256')

    nama = request.form.get('nama_fix')
    email = request.form.get('email_fix')
    telepon = request.form.get('telepon_fix')
    tanggallahir = request.form.get('tanggallahir_fix')
    roleid = request.form.get('roleid_fix')
    subgrupid = request.form.get('subgrupid_fix')
    isactive = 1

    if nama=='':
        flash("Lengkapi formulir pendaftaran", "danger")
        return redirect(url_for('auth.signup'))
    elif email=='':
        flash("Lengkapi formulir pendaftaran", "danger")
        return redirect(url_for('auth.signup'))
    elif telepon=='':
        flash("Lengkapi formulir pendaftaran", "danger")
        return redirect(url_for('auth.signup'))
    elif tanggallahir=='':
        flash("Lengkapi formulir pendaftaran", "danger")
        return redirect(url_for('auth.signup'))
    elif roleid=='':
        flash("Lengkapi formulir pendaftaran", "danger")
        return redirect(url_for('auth.signup'))
    elif subgrupid=='':
        flash("Lengkapi formulir pendaftaran", "danger")
        return redirect(url_for('auth.signup'))
    elif not re.match(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*.#?&])[A-Za-z\d@$!.%*#?&]{8,}$', request.form.get('password')):
        flash("Password must contain minimum eight characters, at least one letter, one number and one special character!", "danger")
        return redirect(url_for('auth.signup'))

    cursor = db.cursor()
    adr = (username,)
    quer = "SELECT * FROM user WHERE Username = %s"
    cursor.execute(quer, adr)
    user = cursor.fetchone()

    # check if there is an user
    if user!=None:
        flash('Username already exists. Go to login page')
        return redirect(url_for('auth.signup'))

    # add new user to database
    adr = (username,nama,email,password,telepon,tanggallahir,roleid,subgrupid,isactive)
    quer = "INSERT INTO user(Username, Nama, Email, Password, Telepon, TanggalLahir, RoleId, SubGrupId,is_active) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s)"
    cursor.execute(quer, adr)
    
    db.commit()
    cursor.close()

    
    flash("Sign up berhasil", "success")
    return redirect(url_for('auth.login'))
    # return render_template('index.html', user=user)

def is_logged_in(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'loggedin' in session:
            return f(*args, **kwargs)
        else:
            flash('Unauthorized, Please login', 'danger')
            return redirect(url_for('auth.login'))
    return wrap

@auth.route('/logout')
@is_logged_in
def logout():
    session.pop('loggedin', None)
    session.pop('id', None)
    session.pop('username', None)
    return redirect(url_for('main.index'))
