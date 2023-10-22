import io
import os

from typing import Annotated

from fastapi import FastAPI, File, UploadFile
from fastapi.responses import HTMLResponse, FileResponse, RedirectResponse
from starlette.status import HTTP_303_SEE_OTHER
from PIL import Image


TMP_FILE_PATH = os.environ.get("TMP_FILE_PATH")

app = FastAPI()


class Api:
    @staticmethod
    def index():
        with open("index.html", "r") as index_file:
            index_page = index_file.read()
        return HTMLResponse(content=index_page, status_code=200)

    @staticmethod
    def process(
        files: Annotated[list[UploadFile], File(description="Multiple files as UploadFile")]
    ):
        if os.path.exists(TMP_FILE_PATH):
            os.remove(TMP_FILE_PATH)
        else:
            print("The file does not exist")
        image_list = []
        for file in files:
            file_content = file.file.read()
            image_list.append(Image.open(io.BytesIO(file_content)))

        n = len(files)
        print(f'Received {n} file(s)')
        if n == 1:
            image_list[0].save(TMP_FILE_PATH)
        else:
            image_list[0].save(TMP_FILE_PATH, save_all=True, append_images=image_list[1:])


@app.post("/uploadfiles/", response_class=RedirectResponse)
async def create_upload_files(
    files: Annotated[list[UploadFile], File(description="Multiple files as UploadFile")],
):
    Api.process(files)
    return RedirectResponse(url="/", status_code=HTTP_303_SEE_OTHER)


@app.get("/downloadfile/")
async def download_file():
    return FileResponse(
        path=TMP_FILE_PATH, media_type="application/octet-stream", filename="pdf_file.pdf"
    )


@app.get("/", response_class=HTMLResponse)
async def home():
    return Api.index()
