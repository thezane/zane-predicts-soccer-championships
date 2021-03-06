newTeam <- function(teamName, fName) {
  team <- list(
    name=teamName,
    fName=fName,
    strNorm=c(0, 0),
    strNormBeta=c(0, 0),
    strAgg=0,
    numUpdates=0,
    updateDate=as.Date("0001-01-01")
  )
  
  class(team) <- "Team"
  team
}

update.Team <- function(team, game, i) {
  team$updateDate <- game$gameDate
  team$strNorm <- game$strNextNorm[i, ]
  team$strNormBeta <- game$strNextNormBeta[i, ]
  team$strAgg <- game$strAggNext[i]
  team$numUpdates <- team$numUpdates +
      game$reliability[i] * game$weightContest
  team
}

getStrs.Team <- function(team, rOptions, tTree) {
  if (team$numUpdates > 0) {
    strNorm <-team$strNorm
    strAgg <- team$strAgg
  }
  else {
	strNorm=rOptions$fTree[[team$fName]]
    strBetas <- rOptions$strBetas
    strAgg <- strNorm %*% strBetas
  }

  teamStrs <- list(strNorm=strNorm, strAgg=strAgg)
  teamStrs
}
