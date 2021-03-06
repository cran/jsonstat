% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/jsonstat-collection.R
\name{as.collection}
\alias{as.collection}
\title{Convert data set into JSON-stat collection}
\usage{
as.collection(..., label = "", href = "", src = NULL, extension = NULL,
  updated = NULL)
}
\arguments{
\item{...}{a named list, the function creates a collection
based on user input like the same way as `list`.}

\item{label}{label of dataset}

\item{href}{href of dataset, "" by default}

\item{src}{source of dataset, NULL by default}

\item{extension}{user data, NULL by default}

\item{updated}{a timestamp for data, NULL by default}
}
\description{
Convert data set into JSON-stat collection
}
