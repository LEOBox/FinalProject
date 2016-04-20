from flask import Flask,render_template

app = Flask(__name__)

@app.route('/index')
def index():
	post = "index"
	return render_template('index.html',post = post)

if __name__ == '__main__':
	app.run(debug=True)