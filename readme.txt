Before running the program, put all the test images in the Breast folder.
Since the program supposed to be general, I comment out reading given mask if it is no needed.
If there are masks to compare result, put all the mask images in the Mask folder.

Once select the project folder in matlab, open the main.m file.  
Line 4-34 is the sample code and is used for reference. 

If there are given masks, you need to manually uncomment line 45-46, and line 72-83.

Then, you need to manually type-in the test image filename in line 40. (EX: 'Breast\Test_Image_18.png') and mask filename in line 45. (EX: 'Mask\mask_18.png'). 
You can use sample code for reference.

The program will output 1 sample result and 1 test image result.

Finally, the program will output results image to the Result folder.