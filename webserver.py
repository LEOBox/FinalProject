# -*- coding: utf-8 -*-
from flask import Flask,session,flash,request
from flask.ext.bcrypt import Bcrypt
from functools import wraps

app = Flask(__name__)
bcrypt = Bcrypt(app)

def login_required(fun):
	@wraps(fun)
	def wrap(*args,**kwargs):
		if 'login' in session:
			return fun(*args,**kwargs)
		else:
			flash('Login required')
			return 'login'

@app.route('/index')
def index():
	return 'index'

@app.route('/login', methods = ['GET','POST'] )
def login():
	error = None
	if request.methods == 'POST':
		'''
		if :
			pass
		else:
			session['login'] = True
			return 'Login'
		'''
		return 'login'
	return 'login page'

@app.route('/')
