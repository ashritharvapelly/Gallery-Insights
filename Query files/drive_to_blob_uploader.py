from pydrive.auth import GoogleAuth
from pydrive.drive import GoogleDrive
from azure.storage.blob import BlobServiceClient
import os

# Azure Blob connection string and container name
AZURE_CONNECTION_STRING = "DefaultEndpointsProtocol=https;AccountName=smartgallerystore;AccountKey=Zq87a2VJOOaoCT7KrcKz5QmhZUxVkUyh6CvOhz5mJU2lu57fQ63lEC6WddKd7I35FVTpk0tonlk++AStoEntjA==;EndpointSuffix=core.windows.net"
AZURE_CONTAINER_NAME = "gallery-images"

# Authenticate Google Drive
gauth = GoogleAuth()
gauth.LocalWebserverAuth()
drive = GoogleDrive(gauth)

# Connect to Azure Blob
blob_service_client = BlobServiceClient.from_connection_string(AZURE_CONNECTION_STRING)
container_client = blob_service_client.get_container_client(AZURE_CONTAINER_NAME)

# Get all folders in My Drive
folder_list = drive.ListFile({'q': "'root' in parents and mimeType = 'application/vnd.google-apps.folder' and trashed=false"}).GetList()

for folder in folder_list:
    folder_name = folder['title']
    print(f"\nProcessing folder: {folder_name}")

    # Get all files in that folder
    file_list = drive.ListFile({'q': f"'{folder['id']}' in parents and trashed=false"}).GetList()
    
    for file in file_list:
        if file['mimeType'] == 'application/vnd.google-apps.folder':
            print(f" - Skipped subfolder: {file['title']}")
            continue

        print(f" - Downloading: {file['title']}")
        try:
            file.GetContentFile(file['title'])
            # Upload to Azure Blob
            with open(file['title'], "rb") as data:
                blob_client = container_client.get_blob_client(blob=os.path.join(folder_name, file['title']))
                blob_client.upload_blob(data, overwrite=True)
                print(f"   ✅ Uploaded to Azure Blob: {folder_name}/{file['title']}")
            os.remove(file['title'])  # Clean up local file
        except Exception as e:
            print(f"   ❌ Failed to download/upload {file['title']}: {e}")
