
    //= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
   //                                                                  //
  //   HOW TO REMOVE NOISE OF STACKS USING THE VSNR_MACRO_3D PLUGINS  //
 //													                 //
//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //


// this variable is the input folder
input = "C:\\Users\\benjamin.font\\Desktop\\Testmacro3D\\";

// this variable is the output folder
output = "C:\\Users\\benjamin.font\\Desktop\\DenoisedTestmacro3D\\";

// this variable is the text file
textfile = "C:\\Users\\benjamin.font\\Desktop\\text.txt";

// this variable is the limiter of the size of each substack to denoise for a stack (must be greater than 1)
max = 3;


// beginning of the algorithm
list = getFileList(input); 
for(i = 0;i<list.length;i++){
	denoiseStack(input,	output,	list[i],max,textfile);	
	close();
}



// this function denoise a stack using the parameters of the text file
// input : the path of the source folder
// output : the path of the destination folder
// filename : the name of the file
// maxsize : the maximum size of the substack to denoise
// textfile : the path the text file to use
function denoiseStack(input,output,filename,maxsize,textfile){
	open(input+filename);
	size = nSlices;
	begin = 1;
	end = 0;
	rest = size%maxsize;
	nb = (size-rest) / maxsize;
	for(i = 0 ; i<nb;i++){
		// we determine the part of the stack to denoise
		begin = end+1;
		last = nb-1;
		if(i!=nb){
			if(i==last){
				end = size;
			}
			else{
				end = begin+maxsize-1;
			}
		}
		// we make a substack and we denoise it
		run("Make Substack...", "  slices="+begin+"-"+end);
		run("VSNR_Macro_3D", "where=[Text File (.txt)] choose=["+textfile+"]");
		selectWindow("Denoised Image");
		saveAs("Tiff", output+filename+"_denoised"+i);
		close();
		close();
		close();
	}
}

