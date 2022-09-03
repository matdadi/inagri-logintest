from flask import Blueprint, render_template
from .auth import is_logged_in
from .database import db

main = Blueprint('main', __name__)

@main.route('/')
def index():
    return render_template('index.html')

@main.route('/profile')
@is_logged_in
def profile():
    cursor = db.cursor()
    cursor.execute("""SELECT user.Username, user.Nama,
                    user.Email, user.Telepon,
                    user.TanggalLahir, roles.Nama,
                    grups.Nama, subgrups.Nama, user.is_active
                    FROM user
                    LEFT JOIN roles ON (user.RoleId = roles.Id)
                    LEFT JOIN subgrups ON (user.SubgrupId = subgrups.Id)
                    LEFT JOIN grups ON (subgrups.Id = grups.Id)""")
    users = cursor.fetchall()
    return render_template('profile.html', user=users)