# ============ KNOT MANAGEMENT ============

reset_multiplicity<-function()
{tn=length(values$knot)
degree<-values$degree
if (tn>=1){
  values$knot_multiplicity<-rep(1,tn)
  update_knot_multiplicity(tn,degree+1)
  update_knot_multiplicity(1,degree+1)
  for (idx in 2:(tn-2) )
  {update_knot_multiplicity(idx,1)}
}
else{showNotification("Not enough knots",type=warning)}
}

update_auto_knots<-function()
{
  req(values$xtab)
  req(input$auto_knot_count >= 2)
  values$auto_knot_count<-input$auto_knot_count

  kn <- values$auto_knot_count - 1

  auto_knot_list<-as.numeric(quantile(values$xtab, probs = seq(0, 1, length.out = kn + 1)))
  values$auto_knot_list<-auto_knot_list #export

  values$knot<-sort(union(auto_knot_list,values$manual_knot))

  degree <- values$degree
  manual<-values$manual_knot

  auto_mult<-rep(1, length(values$auto_knot_list))
  auto_mult[1]<-degree+1
  auto_mult[kn+1]<-degree+1

  values$auto_knot_mult<-auto_mult

  mult <- rep(1, length(values$knot))
  mult[1] <- degree + 1
  mult[length(mult)] <- degree + 1

  values$knot_multiplicity<-mult
  values$knot_extended <- build_knot_sequence(values$knot, mult)

}

clear_manual_knot<-function()
{
  if (is.null(values$manual_knot)){
    showNotification("No manual knot ", type = "warning")
    return()}
  else{

    idm<-c()
    index=1:length(values$knot)
    for (k in (values$manual_knot)){
      idm<-c(idm,index[k==values$knot])}
    #remove values of index idm:

    values$knot_multiplicity<-values$knot_multiplicity[-idm]

    values$manual_knot <- c()
    values$knot<-values$auto_knot_list
    showNotification("manual knots reset", type = "message")
  }}


add_knot<-function()
{
  if (values$adding_knot) {
    click <- event_data("plotly_click", source = "plot")

    if (!is.null(click) && !is.null(values$xtab)) {
      x <- click$x
      if (!any(abs(values$knot - x) < 1e-6))
      {
        #old values
        tn<-values$knot
        ln<-length(tn)
        tn_m<-values$manual_knot
        mn<-length(tn_m)
        manual_mult<-values$manual_knot_multiplicity
        knot_mult<-values$knot_multiplicity

        idx<-length(tn[tn<x])+1 #id the added knot
        idx_m<-length(tn_m[tn_m<x])+1 #id in manual knots list
        #update multiplicity: add a new one


        if (idx==1 || idx==kn+1) {# special case adding new  extreme knot
          mult<-degree+1
          if (!is.null(manual_mult))
          {if (tn_m[1]==tn[1]||tn_m[mn]==tn[ln] )#case the extreme knot is a manual knot : replace its multiplicity
          {manual_mult[idx_m]<-1
          knot_mult[idx]<-1
          }
            manual_mult<-c(manual_mult[1:(idx-1)],mult,manual_mult[idx:mn])
            tn_m<-c(tn_m[1:(idx-1)],x,tn_m[idx:mn])
            mult[idx]<-1 #change the multiplicity in the global list
          }
          else manual_mult<-mult}
        #if (!is.null(values$knot_multiplicity))
        #    {values$knot_multiplicity[1]<-1  # shift first multiplicity to 1
        #values$knot_multiplicity<-c(values$degree+1,values$knot_multiplicity)
      }
      #else values$knot_multiplicity<-values$degree+1 # if only 1 knot
      #}

      #else if (idx==ln+1){ #if last after knot
      #  if (!is.null(values$knot_multiplicity))
      #      {values$knot_multiplicity[ln]<-1 # shift last multiplicity to 1
      #      values$knot_multiplicity<-c(values$knot_multiplicity,values$degree+1)}
      #      else values$knot_multiplicity<-values$degree+1
      #}
      else # case middle of the list
      {mult<-1
      if (!is.null(manual_mult)){
        tn_m<-c(tn[1:(idx-1)],x,tn[idx:mn])
        manual_mult<-c(manual_mult[1:(idx-1)],mult,manual_mult[idx:mn])
      }
      else manual_mult<-mult
      }
      #values$knot_multiplicity<-c(values$knot_multiplicity[1:(idx-1)],1,values$knot_multiplicity[idx:ln])


      #values$manual_knot<-sort(c(values$manual_knot,x))
      #values$knot <- sort(c(values$auto_knot_list,values$manual_knot))

      showNotification(paste("New knot N",idx,"added at x =", round(x, 3)), type = "message")
      #update multiplicities at end if necessary
      values$manuel_knot<-tn_m
      values$manual_knot_multiplicity<-manual_mult
    }
    else {
      showNotification("This knot already exists", type = "warning")
    }

  }
}

remove_knot<-function()
{
  idx <- selected_knot()
  if (is.null(idx) || is.na(idx) ) {showNotification("Select a knot first", type="warning")
    return()}

  if (idx==1 || idx==length(values$knot))
  {showNotification("You removed one end knot", type="warning")
  }
  values$knot<-values$knot[-idx]
  values$knot_multiplicity<-values$knot_multiplicity[-idx]
  #update ends multiplicities
  if (!is.null(values$knot)){
    values$knot_multiplicity[1]<-values$degree+1
    values$knot_multiplicity[length(values$knot) ] <-values$degree+1
  }
}

# Construire la séquence de nœuds avec multiplicités
build_knot_sequence <- function(knots, multiplicities)
{
  # Vérifier les entrées
  if (is.null(knots) || length(knots) == 0) {
    return(c())
  }
  if (length(multiplicities) != length(knots)) {
    message("knots and multiplicities must have same length. Reseting",type='warning')
    reset_multiplicity()
  }

  knot_seq <- c()
  for (i in seq_along(knots)) {
    knot_seq <- c(knot_seq, rep(knots[i], multiplicities[i]))
  }
  return(knot_seq)
}


# Initialiser les nœuds avec multiplicités
init_knots <- function(xtab, n_knots) {
  # Générer des nœuds quantiles
  knot<- as.numeric(quantile(xtab, probs = seq(0, 1, length.out = n_knots + 1)))

  # Multiplicités initiales (1 par défaut pour les nœuds internes)
  # Les extrémités ont multiplicité degree + 1
  degree <- values$degree
  mult <- rep(1, length(knot))
  mult[1] <- degree + 1
  mult[length(mult)] <- degree + 1

  return(list(knot = knot, multiplicities = mult))
}




# Mettre à jour la multiplicité d'un nœud
update_knot_multiplicity <- function(idx, new_mult) {
  if (is.null(values$knot)) return()
  if (idx < 1 || idx > length(values$knot)) return()

  # Ne pas modifier les extrémités
  if (idx == 1 || idx == length(values$knot)) {
    showNotification("Cannot modify endpoint knots!", type = "warning")
    return()
  }

  # Limiter la multiplicité
  degree <- values$degree
  new_mult <- max(1, min(new_mult, degree + 1))

  # Mettre à jour les métadonnées
  values$knot_multiplicity[idx] <- new_mult
  values$knot_multiplicity[1]<-degree+1
  values$knot_multiplicity[length(values$knot)]<-degree+1

  # Reconstruire la séquence étendue
  values$knot_extended <- build_knot_sequence(
    values$knot,
    values$knot_multiplicity
  )

  showNotification(paste("Knot", idx, "multiplicity set to", new_mult),
                   type = "message")
}


inc_multiplicity<-function()
{
  idx <- selected_knot()
  if (is.null(idx)) {
    showNotification("Select a knot first!", type = "warning")
    return()
  }
  # Vérifier que ce n'est pas un nœud d'extrémité
  if (idx == 1 || idx == length(values$knot)) {
    showNotification("Cannot modify endpoint knots!", type = "warning")
    return()
  }
  current_mult <- values$knot_multiplicity[idx]
  update_knot_multiplicity(idx, current_mult + 1)
  showNotification(paste("Increased multiplicity of knot", idx), type = "message")
}

dec_multiplicity<-function()
{
  idx <- selected_knot()
  if (is.null(idx)) {
    showNotification("Select a knot first!", type = "warning")
    return()
  }
  if (idx == 1 || idx == length(values$knot)) {
    showNotification("Cannot modify endpoint knots!", type = "warning")
    return()
  }

  current_mult <- values$knot_multiplicity[idx]
  update_knot_multiplicity(idx, current_mult - 1)
  showNotification(paste("Decreased multiplicity of knot", idx), type = "message")
}

#update knots multiplicities
update_knot_multiplicity_1<-function()
{
  if (is.numeric(input$degree)) values$degree<-max(input$degree,0)
  if (!is.null(values$knot_multiplicity)){
    kn<-length(values$knot)-1
    degree<-values$degree
    values$knot_multiplicity[1]<-degree+1
    values$knot_multiplicity[kn+1]<-degree+1
    #limit intern multiplicities
    for (i in 2:kn){
      if (values$knot_multiplicity[i]>(degree+1))
      {
        values$knot_multiplicity[i]<-degree+1
      }}
  }

}


#

# ============ CONSTRAINT CONSTRUCTION ============


build_constraints <- function() {


  if (is.null(values$knot)) {
    showNotification("No knots available!", type = "warning")
    return(NULL)
  }
  if (is.na(values$degree)) degree<-3 else degree<-values$degree
  kn <- length(values$knot) - 1
  # Contraintes uniformes
  if (input$constraint_mode == "uniform") {
    monot_val <- as.numeric(input$monot)
    conv_val <- as.numeric(input$conv)
    der3_val <- as.numeric(input$der3)

    if (is.na(monot_val)) monot_val <- 0
    if (is.na(conv_val)) conv_val <- 0
    if (is.na(der3_val)) der3_val <- 0

    monot <- rep(monot_val, kn + 1)
    conv <- rep(conv_val, kn + 1)
    der3 <- rep(der3_val, kn + 1)

    if (degree < 3) {der3 <- rep(0, kn + 1)}

  }
  else {
    # Mode région
    monot <- rep(0, kn+1)
    conv <- rep(0, kn + 1)
    der3 <- rep(0, kn + 1)

    for (region in values$regions) {
      for (i in 1:kn) {
        x1 <- values$knot[i]
        x2 <- values$knot[i + 1]
        if (x2 > region$xmin && x1 < region$xmax) {
          if (region$monot != 0) monot[i] <- region$monot
          if (region$conv != 0) {
            conv[i] <- region$conv
            conv[i + 1] <- region$conv
          }
          if (region$der3 != 0 && degree >= 3) {
            der3[i] <- region$der3
          }
        }
      }
    }
  }

  if (input$consider_multiplicity)
  {
    mult_monot<-c(monot[1])
    mult_conv<-c(conv[1])
    mult_der3<-c(der3[1])

    for (i in 2:kn)
    {
      mult_monot<-c(mult_monot,rep(monot[i],values$knot_multiplicity[i]))
      mult_conv<-c(mult_conv,rep(conv[i],values$knot_multiplicity[i]))
      mult_der3<-c(mult_der3, rep(der3[i],values$knot_multiplicity[i]))
    }
    mult_monot<-c(mult_monot,monot[kn+1])
    mult_conv<-c(mult_conv,conv[kn+1])
    mult_der3<-c(mult_der3,der3[kn+1])

    monot<-mult_monot
    conv<-mult_conv
    der3<-mult_der3
  }

  return(list(
    monot = monot,
    conv = conv,
    der3 = der3
  ))
}





