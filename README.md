# *Weissella confusa* analysis

Repository that contain the workflow followed in the manuscript:

***Weissella confusa* and its potential to assimilate pozol carbohydrates**

This work was carried out at the Biotechnology Institute of the National Autonomous University of Mexico, in the Enzymatic Technology laboratory led by **Dr. Agustín López Munguía Canales**.

All analysis were done on the "chichen" server of the UNAM Center for Genomic Sciences.

### Workflow

The Analysis were performed following this workflow, which can be found in the **analysis** directory and its results in the **out** directory of this repository.

1. Taxonomy_16S

   ```
   
   ```

2. Genome assemblies

   ```
   quality_and_assemblies.sh
   assembly_refinement.sh
   compare_assemblies_and_coverage_estimation.sh
   ```

3. Weissella taxonomic assignment

   ```
   housekeeping_genes_phylogeny.sh
   ribosomal_proteins_phylogeny.sh
   ANI.sh
   ```

4. CAZy anotate

   ```
   cazy_analysis.sh
   ```

5. Plots

   ```
   Boxplots_OD_and_Enzymatic_activity.R
   CAZy_heatmap.R
   ```



####                                                   *Pozol*

<img src="Pozol.jpg" style="zoom:5%;" />
```html
<center><i><b>Nijmé</b></i></center>
<center>Nga tjo ts’ien nijmé,</center>
<center>xikoni tsa kjifí nixtjíná,</center>
<center>inimána xi titjó, xi kjamaxcha,</center>
<center>kuí xi nda, kuí xi nño,</center>
<center>kuí xi ngasandie, kuí xi inimana.</center>
<center><b>El maíz</b></center>
<center>Cuando brota el embrión del maíz,</center>
<center>siento que se prolongan nuestros días,</center>
<center>es nuestro corazón que germina y crece,</center>
<center>es el pozol, es la tortilla,</center>
<center>es el mundo, es la vida.</center>
<center>JUAN GREGORIO REGINO (poeta mazateco)</center>
```

![](maiz.png)

