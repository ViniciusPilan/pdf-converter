import os

from PIL import Image
from flask import Flask, request, send_file, render_template
from pdf_converter import get_RGB_images_from_files, create_pdf_from_images


app = Flask(__name__, template_folder='/home/api/')


@app.route('/', methods=['GET'])
def index(): 
    return render_template('index.html')

@app.route('/pdf', methods=['POST'])
def create_pdf_from_image_files():
    """ Merge a list of image files into a PDF file. """
    images_files = request.files['images']
    rgb_images = get_RGB_images_from_files(images_files)
    pdf_file = create_pdf_from_images(rgb_images)
    return send_file(pdf_file)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)