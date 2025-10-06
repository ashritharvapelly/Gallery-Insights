CREATE TABLE ImageMetadataSilver (
    file_name NVARCHAR(255),
    folder_name NVARCHAR(255),
    file_size_mb FLOAT,
    last_modified DATETIME,
    file_type NVARCHAR(50),
    file_extension NVARCHAR(10),
    relative_path NVARCHAR(500),
    created_date DATETIME DEFAULT GETDATE(),
    upload_timestamp DATETIME,
    source_container NVARCHAR(100),
    target_container NVARCHAR(100),
    is_duplicate BIT,
    is_new_folder BIT,
    sas_url NVARCHAR(MAX),
    file_category NVARCHAR(100),
    device_type NVARCHAR(50),
    image_width INT,
    image_height INT,
    duration_sec FLOAT
);

select * from ImageMetadataSilver

CREATE PROCEDURE InsertImageMetadata
    @file_name NVARCHAR(255),
    @folder_name NVARCHAR(255),
    @file_size_mb FLOAT,
    @last_modified DATETIME,
    @file_type NVARCHAR(50),
    @file_extension NVARCHAR(10),
    @relative_path NVARCHAR(500),
    @upload_timestamp DATETIME,
    @source_container NVARCHAR(100),
    @target_container NVARCHAR(100),
    @is_duplicate BIT,
    @is_new_folder BIT,
    @sas_url NVARCHAR(MAX),
    @file_category NVARCHAR(100),
    @device_type NVARCHAR(50),
    @image_width INT,
    @image_height INT,
    @duration_sec FLOAT
AS
BEGIN
    INSERT INTO ImageMetadataSilver (
        file_name, folder_name, file_size_mb, last_modified, file_type, 
        file_extension, relative_path, upload_timestamp, source_container, 
        target_container, is_duplicate, is_new_folder, sas_url, 
        file_category, device_type, image_width, image_height, duration_sec
    )
    VALUES (
        @file_name, @folder_name, @file_size_mb, @last_modified, @file_type, 
        @file_extension, @relative_path, @upload_timestamp, @source_container, 
        @target_container, @is_duplicate, @is_new_folder, @sas_url, 
        @file_category, @device_type, @image_width, @image_height, @duration_sec
    );
END;

