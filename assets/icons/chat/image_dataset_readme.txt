Images of pills inside medication bottles dataset Readme


Research Overview
The dataset contains images of pills inside a medication bottle from a top down view. The dataset was used to build an image classification model for predicting the national drug code (NDC) of the medication seen in the image. There are 13,955 images of 20 distinct NDC. The image data were used to create a machine learning algorithm which could predict the NDC.  This dataset was used in R01LM013624 from the National Library Medicine in the National Institutes of Health.  The grant was awarded to Corey Lester, Raed Al Kontar, and Jessie Xi Yang at the University of Michigan.


Methodology
This dataset includes images of pills inside medication bottles. The images were taken by a robot in the pharmacy that counts out pills into the bottle and takes a photo of the pills inside the bottle from a top down view. The data were obtained from a mail order pharmacy in the United States. Each image is labeled with an ID number and also includes the national drug code (NDC) for the medication inside the bottle. The NDC identifies the medication product on the basis of ingredient, strength, dose form, and manufacturer. The dataset was split into training/validation/testing subsets for each NDC using a ratio of 6:2:2. Each sub-folder is labeled with the NDC and images inside the sub-folder correspond to the NDC.


File Inventory
The image dataset contains 3 main folders: 1. Train, 2. Test, and 3. Valid datasets.  Within each of these folders exists 20 sub-folders.  Each sub-folder is labeled with the NDC for which the images inside that sub-folder corresponds to.  The NDC are the same in each main folder.  Within each NDC folder, .jpg images of pills for that NDC are labeled with an image ID as the file name.  The following shows the folder hierarchy:
* Main folder (i.e., train, test, valid)
   * NDC (e.g., 00378-0208)
      * Image ID (e.g., 2082.jpg)


Definition of Terms and Variables
* Train: the folder containing the pill images used to train the model.
* Test: the folder containing the pill images used to test the model.
* Valid: the folder containing the pill images used to validate the model.
* National Drug Code (NDC): a unique identifier for medication ingredient, strength, dose form, and manufacturer.  Each NDC folder contains the pill images corresponding to the respective NDC.