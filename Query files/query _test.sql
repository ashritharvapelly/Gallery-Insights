CREATE TABLE ImageMetadataSilver_test (
    file_name NVARCHAR(255),
    folder_name NVARCHAR(255),
    file_size_mb FLOAT
);

select * from ImageMetadataSilver_test

CREATE PROCEDURE InsertImageMetadata_test
    @file_name NVARCHAR(255),
    @folder_name NVARCHAR(255),
    @file_size_mb FLOAT
AS
BEGIN
    INSERT INTO ImageMetadataSilver_test (
        file_name, folder_name, file_size_mb
    )
    VALUES (
        @file_name, @folder_name, @file_size_mb
    );
END;
