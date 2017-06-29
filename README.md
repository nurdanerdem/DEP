# DEP
A simple MATLAB GUI for plotting dielectrophoretic (DEP) response of the cells based on the single shell cell model given cell’s dielectric parameters such as conductivity, permittivity, radius and cell membrane thickness. It allows you to test the DEP response of cells numerically, before starting a DEP experiment. 
Released Date: June, 2017 MATLAB (R2016a)

## Prerequisites
* MATLAB 
* Knowledge of dielectric parameters for the cells being investigated.

### Installing
Download the following files and run them in MATLAB and make sure that corresponding .m and .fig files are in the same directory. 
*	DEP_Response_1.m 
*	DEP_Response_1.fig
*	DEP_Response_2.m
*	DEP_Response_2.fig

DEP_Response_1.m is for plotting DEP response of only one cell. After you run it, a pop-up window will appear showing empty fields to be filled with DEP parameters. 
For a single-shelled cell, dielectric parameters to be entered are;
*	Radius of cell (micrometers)
*	Thickness of cell membrane (nanometers)
*	Membrane conductivity (Siemens/meter, a.k.a. outer conductivity) 
*	Cytoplasm conductivity (Siemens/meter, a.k.a. inner conductivity)
*	Conductivity of the suspending medium (Siemens/meter)
*	Membrane permittivity (a.k.a. outer permittivity) 
*	Cytoplasm permittivity ( a.k.a. inner permittivity)
*	Permittivity of the suspending medium (usually taken as 80xℇ_0 )
*	Folding factor (take as 1 if not known)


ℇ_0  is called the permittivity of free space and taken as 8.85 x 10-12. It is included in the calculation already, so please only enter the coefficient part of the permittivities (i.e enter 80 for a permittivity of 80xℇ_0). 

For more information about the folding factor, please refer to the article : Erdem, N., Yıldızhan, Y., Elitaş, M., 2017. *A numerical approach for dielectrophoretic characterization and separation of human hematopoietic cells* , International Journal of Engineering Research & Technology (IJERT) 6, 1079-1082.

After all the fields are filled with parameters, click on “Plot DEP Response” button.
The resulting DEP response curve will be plotted and the resulting crossover frequency will be displayed in kHz. 
 
DEP_Response_2 uses the same set of parameters for plotting DEP response curves of two different cells so that they can be compared easily. If one wants to separate two cells by using DEP, he/she can test their separation numerically without starting an experiment. 
### Running the tests
See Sample_DEP_Parameters.docx 
### Author
Nurdan Erdem 
### License
This project is licensed under the MIT License - see the LICENSE.md file for details
### Acknowledgments
Visit Biomechatronics Group’s website: http://myweb.sabanciuniv.edu/melitas/


