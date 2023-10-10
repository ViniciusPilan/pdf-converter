import os
from PIL import Image


OUTPUT_FILENAME = 'file.pdf'


def get_RGB_images_from_files(files_list:list) -> list:
    """ Receive a list of files and convert it to a RGB images list. """
    try:
        rgb_images = []
        for file in files_list:
            rgb_images.append(Image.open(file.stream).convert('RGB'))
        return rgb_images
    except Exception as e:
        print(f'Erro na abertura das imagens: {type(e).__name__}\n{e}')
        return None

def create_pdf_from_images(images_list):
    """ Merge a list of RGB images into a PDF file. """
    try:
        images_list[0].save(OUTPUT_FILENAME, save_all = True, append_images = images_list[1:])
        print(f'Arquivo gerado com sucesso: {OUTPUT_FILENAME}')
        with open(f'{OUTPUT_FILENAME}', 'r') as pdf_file:
            return pdf_file
    except Exception as e:
        print(f'Erro na criação do PDF: {type(e).__name__}\n{e}')
        return None
