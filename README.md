# GRASS GIS Scripts — Monthly Random Forest Land-Cover Classification over Etosha, Namibia

GRASS GIS shell scripts used in the peer-reviewed article by Polina Lemenkova. This repository holds the monthly Random Forest machine-learning classification scripts for a Landsat 8-9 OLI/TIRS series (March–August 2022) over the Etosha region of Namibia, used to track seasonal lake drainage and vegetation dynamics in an arid ecosystem.

**Published in:** *Journal of the Department of Geography, Tourism and Hotel Management (Zbornik radova Departmana za geografiju, turizam i hotelijerstvo)* **2025**, *54*(1), 1–19
**DOI:** https://doi.org/10.5937/ZbDght2501001L
**Journal (open access):** https://www.dgt.uns.ac.rs/dokumentacija/zbornik/54-1/en/01en.pdf
**HAL:** https://hal.science/hal-05171540v1
**Zenodo:** https://doi.org/10.5281/zenodo.16217948
**SSRN:** https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5359126

## Contents
One script per month (March to August 2022), each calling GRASS GIS modules for raster import (r.import), colour composites (r.composite), band grouping (i.group), unsupervised clustering (i.cluster, k-means), maximum-likelihood classification (i.maxlik), training-sample generation (r.random) and Random Forest machine-learning classification (r.learn.train, r.learn.predict) using Python's Scikit-Learn library.

## Related repositories
- LaTeX source (article prose): https://github.com/paulinelemenkova/random-forest-ensemble-classification-namibia
- Random Forest / MaxLike ensemble scripts (cited in the article's Data Availability): https://github.com/paulinelemenkova/Namibia_Etosha_GRASS_GIS_Ensemble_Learning

## Citation
Lemenkova, P. Climatic influence on the lake drainage processes and vegetation dynamics in arid ecosystems of southern Africa. *Journal of the Department of Geography, Tourism and Hotel Management* **2025**, *54*(1), 1–19. https://doi.org/10.5937/ZbDght2501001L
