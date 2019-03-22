The following repository does some analysis and some prediction for a star cluster simulation for a set of 64000 different stars over time. <br/>
The number of timestamps present in the dataset is 19, each separated by a few hundred years.<br/>
The data set consists of 8 columns. The columns are x,y,z,vx,vy,vz,mass and the id of the star(to identify which star the corresponding data is present for).<br/>
Since the difference in the position of the stars happens very rarely with time, the number of timestamps that show a significant difference is lesser.
To run the repository, git clone the repository<br/>
Start with the exploratory data analytics that is done in R(EDA.r) which shows analysis of the aspects of the dataset and it shows whether there is any correlation between any of the columns.<br/>
To see how different the clusters are with the different timestamp, run the clustervisualization.rmd file. Its a r markdown file that visualizes how the cluster moves.<br/>
This visualization is done in plotly and can be rotated to see the visualization in different angles.
<br/><br/>
To generalize the position of a star, The distance and velocity vectors were created and the magnitude of velocity and distance was used for analysis in time series.

The commits tell what the notebook really is and there is analysis in each file for better understanding of the model.<br/>

<br/><br/><br/><br/><br/><br/>
NOTE: Some of the code was done on Windows platform and some of them were done in Linux platform. So there could be difference in the import statements of the path. If you are running on Windows platform, change the '/' in the path to '\\' and if you are running it on ubuntu, then change the '\\' to '/'.<br/>

