\name{sem.fisher.c}

\alias{sem.fisher.c}

\title{
Goodness-of-fit test for piecewise SEM
}

\description{
Evaluates independence claims for a piecewise structural equation model (SEM), and calculates Fisher's C and associated p-value to evaluate model fit.
}

\usage{
sem.fisher.c(modelList, data, corr.errors, add.vars, grouping.vars, grouping.fun,
  adjust.p, basis.set, pvalues.df, model.control, .progressBar) 
}

\arguments{

\item{modelList}{
a \code{list} of regressions representing the structural equation model. 
}

\item{data}{
a \code{data.frame} used to construct the structured equations.
}

\item{corr.errors}{
a vector of variables with correlated errors (separated by "~~").
}

\item{add.vars}{
a vector of additional variables whose independence claims should be evaluated, but which do not appear in the model list.
}

\item{grouping.vars}{
an optional variable that represents the levels of data aggregation for a multi-level dataset.
}

\item{grouping.fun}{
a function defining how variables are aggregated in \code{grouping.vars}. Default is \code{mean}.
}

\item{adjust.p}{
whether p-values degrees of freedom should be adjusted (see below). Default is \code{FALSE}.
}

\item{basis.set}{
provide an optional basis set.
}

\item{pvalues.df}{
an optional \code{data.frame} corresponding to p-values for independence claims.
}

\item{model.control}{
a \code{list} of model control arguments to be passed to d-sep models.
}

\item{.progressBar}{
enable optional text progress bar. Default is \code{TRUE}.
}

}

\value{
Returns a \code{data.frame} with the first entry corresponding to Fisher's C statistic, the second corresponding to the Chi-squared test degrees of freedom, and the third corresponding to the outcome (p-value) of the significance test derived from a Chi-squared distribution.

For linear mixed effects models, p-values can be adjusted to accommodate the full model degrees of freedom using the argument \code{p.adjust = TRUE}. For more information, see Shipley 2013.
}

\references{
Shipley, Bill. "Confirmatory path analysis in a generalized multilevel context." Ecology 90.2 (2009): 363-368.
}

\author{
Jon Lefcheck
}

\examples{
# Load example data
data(shipley2009)

# Reduce dataset for example
shipley2009.reduced = shipley2009[1:200, ]

# Load model packages
library(lme4)
library(nlme)

# Create list of models 
  shipley2009.reduced.modlist = list(
    
    lme(DD ~ lat, random = ~1|site/tree, na.action = na.omit, 
        data = shipley2009.reduced),
    
    lme(Date ~ DD, random = ~1|site/tree, na.action = na.omit, 
        data = shipley2009.reduced),
    
    lme(Growth ~ Date, random = ~1|site/tree, na.action = na.omit, 
        data = shipley2009.reduced),
    
    glmer(Live ~ Growth+(1|site)+(1|tree), 
          family=binomial(link = "logit"), data = shipley2009.reduced) 
    
  )
  
# Get goodness-of-fit statistics
sem.fisher.c(shipley2009.reduced.modlist, shipley2009.reduced)

\dontrun{
  # Repeat with full dataset as in Shipley (2009)

  # Create list of models 
  shipley2009.modlist = list(
    
    lme(DD ~ lat, random = ~1|site/tree, na.action = na.omit, 
        data = shipley2009),
    
    lme(Date ~ DD, random = ~1|site/tree, na.action = na.omit, 
        data = shipley2009),
    
    lme(Growth ~ Date, random = ~1|site/tree, na.action = na.omit, 
        data = shipley2009),
    
    glmer(Live ~ Growth+(1|site)+(1|tree), 
          family=binomial(link = "logit"), data = shipley2009) 
    
  )

  # Get goodness-of-fit statistics
  sem.fisher.c(shipley2009.modlist, shipley2009)
  }
}