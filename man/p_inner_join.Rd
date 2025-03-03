% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dtrackr.R
\name{p_inner_join}
\alias{p_inner_join}
\title{Inner joins}
\usage{
p_inner_join(
  x,
  y,
  by = NULL,
  copy = FALSE,
  suffix = c(".x", ".y"),
  ...,
  .messages = c("{.count.lhs} on LHS", "{.count.rhs} on RHS",
    "{.count.out} in linked set"),
  .headline = "Inner join by {.keys}"
)
}
\arguments{
\item{x, y}{A pair of data frames, data frame extensions (e.g. a tibble), or
lazy data frames (e.g. from dbplyr or dtplyr). See \emph{Methods}, below, for
more details.}

\item{by}{A character vector of variables to join by.

If \code{NULL}, the default, \verb{*_join()} will perform a natural join, using all
variables in common across \code{x} and \code{y}. A message lists the variables so that you
can check they're correct; suppress the message by supplying \code{by} explicitly.

To join by different variables on \code{x} and \code{y}, use a named vector.
For example, \code{by = c("a" = "b")} will match \code{x$a} to \code{y$b}.

To join by multiple variables, use a vector with length > 1.
For example, \code{by = c("a", "b")} will match \code{x$a} to \code{y$a} and \code{x$b} to
\code{y$b}. Use a named vector to match different variables in \code{x} and \code{y}.
For example, \code{by = c("a" = "b", "c" = "d")} will match \code{x$a} to \code{y$b} and
\code{x$c} to \code{y$d}.

To perform a cross-join, generating all combinations of \code{x} and \code{y},
use \code{by = character()}.}

\item{copy}{If \code{x} and \code{y} are not from the same data source,
and \code{copy} is \code{TRUE}, then \code{y} will be copied into the
same src as \code{x}.  This allows you to join tables across srcs, but
it is a potentially expensive operation so you must opt into it.}

\item{suffix}{If there are non-joined duplicate variables in \code{x} and
\code{y}, these suffixes will be added to the output to disambiguate them.
Should be a character vector of length 2.}

\item{...}{Other parameters passed onto methods.}

\item{.messages}{a set of glue specs. The glue code can use any global
variable, \{.keys\} for the joining columns, \{.count.lhs\},
\{.count.rhs\}, \{.count.out\} for the input and output dataframes sizes
respectively}

\item{.headline}{a glue spec. The glue code can use any global variable,
\{.keys\} for the joining columns, \{.count.lhs\}, \{.count.rhs\},
\{.count.out\} for the input and output dataframes sizes respectively}
}
\value{
the join of the two dataframes with the history graph updated.
}
\description{
Mutating joins behave as \code{dplyr} joins, except the history graph of the two
sides of the joins is merged resulting in a tracked dataframe with the
history of both input dataframes. See \code{\link[dplyr:mutate-joins]{dplyr::inner_join()}} for more details
on the underlying functions.
}
\examples{
library(dplyr)
library(dtrackr)
# Joins across data sets

# example data uses the dplyr starways data
people = starwars \%>\% select(-films, -vehicles, -starships)
films = starwars \%>\% select(name,films) \%>\% tidyr::unnest(cols = c(films))

lhs = people \%>\% track() \%>\% comment("People df {.total}")
rhs = films \%>\% track() \%>\% comment("Films df {.total}") \%>\%
  comment("a test comment")

# Inner join
join = lhs \%>\% inner_join(rhs, by="name") \%>\% comment("joined {.total}")
# See what the history of the graph is:
join \%>\% history() \%>\% print()
nrow(join)
# Display the tracked graph (not run in examples)
# join \%>\% flowchart()

# Left join
join = lhs \%>\% left_join(rhs, by="name") \%>\% comment("joined {.total}")
# See what the history of the graph is:
join \%>\% history()
nrow(join)

# Full join
join = lhs \%>\% full_join(rhs, by="name") \%>\% comment("joined {.total}")
# See what the history of the graph is:
join \%>\% history()
nrow(join)

# Semi join
join = lhs \%>\% semi_join(rhs, by="name") \%>\% comment("joined {.total}")
# See what the history of the graph is:
join \%>\% history()
nrow(join)

# Anti join
join = lhs \%>\% anti_join(rhs, by="name") \%>\% comment("joined {.total}")
# See what the history of the graph is:
join \%>\% history()
nrow(join)

# Nest join
join = lhs \%>\% nest_join(rhs, by="name") \%>\% comment("joined {.total}")
# See what the history of the graph is:
join \%>\% history()
nrow(join)







}
\seealso{
dplyr::inner_join()
}
