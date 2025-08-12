    //= = = = = = = = = = = = = = = = = = = = = = = = = = //
   //                                                    //
  //   HOW TO USE VSNR PLUGIN ON A COMPLETE DIRECTORY   //
 //													   //
//= = = = = = = = = = = = = = = = = = = = = = = = = = //


// this variable is the input folder
input = "C:\\Users\\benjamin.font\\Desktop\\StackLise\\";

// this variable is the output folder
output = "C:\\Users\\benjamin.font\\Desktop\\DenoisedStackLise\\";

list = getFileList(input);
setBatchMode(true); 
for(i = 0;i<list.length;i++){
	denoiseImage(input,	output,	list[i]);
}

function denoiseImage(input, output,filename){
	open(input+filename);
	run("VSNR_Macro_2D", "where=[Text File (.txt)] choose=[C:\\Users\\benjamin.font\\Desktop\\text.txt]");
	close();
	saveAs("Tiff", output+filename+"_denoised");
	close();
	close();
}