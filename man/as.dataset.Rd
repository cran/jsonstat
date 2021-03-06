% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/jsonstat-dataset.R
\name{as.dataset}
\alias{as.dataset}
\title{Convert data frame into JSON-stat dataset}
\usage{
as.dataset(x, .plan, label, href = "", src = NULL, extension = NULL,
  updated = NULL)
}
\arguments{
\item{x}{data frame}

\item{.plan}{compress plan}

\item{label}{label of dataset}

\item{href}{href of dataset, "" by default}

\item{src}{source of dataset, NULL by default}

\item{extension}{user data, NULL by default}

\item{updated}{a timestamp for data, NULL by default}
}
\description{
Convert data frame into JSON-stat dataset
}
