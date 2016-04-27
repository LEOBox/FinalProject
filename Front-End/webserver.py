# -*- coding: utf-8 -*-
from flask import Flask,render_template

app = Flask(__name__)

@app.route('/')
def function():
	return render_template('index.html')

@app.route('/login')
def login():
	return render_template('login.html')

@app.route('/register')
def register():
	return render_template('register.html')

@app.route('/bill')
def bill():
	return render_template('bill.html')

if __name__ == '__main__':
	app.run(debug=True)