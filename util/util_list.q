\d .util

/
  Generate a list with fixed width between elements
  @param lb: (Integer/Long/Float/Date) lower bound
  @param ub: (Integer/Long/Float/Date) Upper bound
  @param space : spacing between each element

  @return a list of values with the same data type as the lower/upper bound,
          with each element of given spacing (space)

  Example:
  .util.genRngLst . (125 150 2.5f)
  .util.genRngLst . (1 9 1j)
  .util.genRngLst . ((.z.d-7);.z.d;2)
\
.util.genRngLst:{[lb;ub;space] ((neg[space]+)\[lb<;ub]) };

\d .
