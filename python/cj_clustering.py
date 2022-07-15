#!/usr/bin/env python
# coding: utf-8
# from sklearn.manifold import TSNE
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import pandas as pd
import hdbscan
import umap

data = pd.read_csv('../data/for_caspar.csv')

df = data.filter(regex=('^kt\d'))
print(list(df))



plot_kwds = {'alpha' : 0.5, 's' : 80, 'linewidths':0}
# projection = TSNE().fit_transform(df)
# plt.scatter(*projection.T, **plot_kwds)
# plt.show()

reducer = umap.UMAP(random_state=42,
                    n_neighbors = 15,
                    min_dist = .5)

reducer.fit(df)

embedding = reducer.fit_transform(df)

# pd.DataFrame(embedding).to_csv('umap.csv', sep='\t')

# plt.scatter(*embedding.T, **plot_kwds)
# plt.show()

clusterer = hdbscan.HDBSCAN(min_cluster_size=40, prediction_data=True).fit(df)
# color_palette = sns.color_palette('Paired', 12)
# cluster_colors = [color_palette[x] if x >= 0
#                   else (0.5, 0.5, 0.5)
#                   for x in clusterer.labels_]
# cluster_member_colors = [sns.desaturate(x, p) for x, p in
#                          zip(cluster_colors, clusterer.probabilities_)]
# plt.scatter(*embedding.T, s=50, linewidth=0, c=cluster_member_colors, alpha=0.25)


soft_clusters = hdbscan.all_points_membership_vectors(clusterer)
color_palette = sns.color_palette('Paired', 12)
cluster_colors = [color_palette[np.argmax(x)]
                  for x in soft_clusters]
plt.scatter(*embedding.T, s=50, linewidth=0, c=cluster_colors, alpha=0.25)
plt.show()