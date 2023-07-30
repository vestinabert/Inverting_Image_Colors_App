# InvertingImageColorsApp

# Table of contents
1. [Introduction](#introduction)
2. [Requirements](#requirements)
3. [Functionality](#functionality)
4. [Methodology](#methodology)
5. [Implementation](#implementation)
    1. [Function "select"](#select)
    2. [Function "convert"](#convert)
    3. [Function "reset"](#reset)
    4. [Function "export"](#export)
6. [Testing](#testing)

## The project's goal and a brief description: <a name="introduction"></a>
This tool can be used to create photo editing software, or it can assist visually impaired individuals in easily perceiving the content of an image. The project aims to create an application that performs the inversion operation by converting each pixel's color to its opposite color within the color spectrum. This will be achieved by reversing the brightness value of each pixel in every color channel.

## Requirements: <a name="requirements"></a>
#### Formats:
The tool will work with images, so support for jpg/jpeg, bmp, and png formats should be provided.

#### Result Saving: 
The tool will be intended for photo editing, so there should be a function to save the processed image in a chosen folder.

#### User Interface: 
The tool is designed for beginners, so the user interface should be simple and clear.

#### Independent Application: 
The application should be independent because not all users can download the MATLAB software.

## Functionality: <a name="functionality"></a>
#### Function "select":
The function is intended to use a standard dialog to select a photo from the computer.

#### Function "convert": 
The function is designed to invert the imported photo and display the result in the output field. 

#### Function "reset": 
The function is meant to clear the canvas and reset the application to its initial state. 

#### Function "export": 
The function is used to export the inverted photo to a user-chosen location on the computer in the desired format using a standard dialog. 


## Methodology: <a name="methodology"></a>
The RGB color system will be used for the color inversion function, which utilizes three colors: red, green, and blue. The values of red, green, and blue colors can range from 0 to 255. When inverting colors, we need to find the complementary of each color on the opposite end of the spectrum. For example, if a color has R(10), G(75), B(200), then these values need to be subtracted from the spectrum's end, which is 255. Applying this color inversion algorithm will result in the color R(255-10=245), G(255-75=180), B(255-200=55). <br><br>
![RGBcolor](https://github.com/vestinabert/InvertingImageColorsApp/assets/127593981/ecc18475-f43b-4563-87e0-29654768d300) <br><br>
![InvertedRGBcolor](https://github.com/vestinabert/InvertingImageColorsApp/assets/127593981/2f11c951-d80b-4eba-8292-e94d401928d4)

## Implementation: <a name="implementation"></a>
#### Function "select":  <a name="select"></a>
A filter was created to limit file options and applied to the "uigetfile" function, which allows selecting a file from the computer using a standard dialog.
```c
filter = {'*.png';'*.jpg';'*.jpeg';'*.bmp'};
[file, path]=uigetfile(filter);
```
Then, an "if" statement was created for the case when the user cancels their actions without selecting a file.
```c
if isequal(file,0)
 figure(app.UIFigure);
 return;
end
```

With the "imshow" function, the selected file is displayed on the left axis, and a title is assigned to the axis.
```c
imshow(app.imginput,'parent',app.UIAxes);
title (app.UIAxes, "Pradinė nuotrauka");
```

#### Function "convert": <a name="convert"></a>
The image result was assigned the initial photo's values, which were subtracted from 255. This way, the inverted image was obtained, and it was loaded into the right axis using the "imshow" function, with a title assigned using the "title" function.
```c
app.imgoutput= 255-app.imginput;
imshow(app.imgoutput,'parent',app.UIAxes2);
title (app.UIAxes2, "Inverted picture");
```

#### Function "reset": <a name="reset"></a>
To clear the axes, the "cla" function was used, and variables were cleared by assigning empty values.
```c
cla(app.UIAxes, 'reset')
cla(app.UIAxes2, 'reset')
app.imginput="";
app.imgoutput="";
set(app.UIAxes, 'visible', 'off');
set(app.UIAxes2, 'visible', 'off');
```

#### Function "export": <a name="export"></a>

The same filter for file format saving was applied to the function, and with the "uiputfile" function, using a standard dialog, the location and name to save the file were obtained. Then, using the "imwrite" function, the file was saved according to the user's preferences.
```c
filter = {'*.png';'*.jpg';'*.jpeg';'*.bmp'};
global pathname;
pavadinimas=fullfile(pathname,filter);
[fileName, folder]=uiputfile(pavadinimas, "Eksportuoti nuotrauką");
if fileName ==0
 return;
end
pilnaspavadinimas=fullfile(folder, fileName);
imwrite(app.imgoutput,pilnaspavadinimas);
```

## Testing: <a name="testing"></a>
Initially, the interface was tested with black and white images to clearly observe color inversion.<br><br>
![testing](https://github.com/vestinabert/InvertingImageColorsApp/assets/127593981/f6888cbe-b283-4196-93c9-f3f4747843e4)

Afterwards, testing was conducted with color images to ensure the functionality works correctly with colored pictures.<br><br>
![testing2](https://github.com/vestinabert/InvertingImageColorsApp/assets/127593981/88d7d614-ad0c-4186-8e99-c50d2708a595)

Further testing was extended to various file formats. Problems were encountered only with one format - png. When uploading an illustration with a transparent background, the tool automatically adds a black background.<br><br>
![testing3](https://github.com/vestinabert/InvertingImageColorsApp/assets/127593981/301a9e42-d0b3-4739-88a1-aa7262b3d2a4)



