!**********************************************************************
module rns_base_ls
!**********************************************************************
use types, only : rprec
use param, only : ld, ny, nz
implicit none

save
private

public reslv_elem_t, beta_elem_t, rbeta_elem_t

!---------------------------------------------------
! RNS PARAMETERS
!---------------------------------------------------  
!logical, parameter :: clforce_calc = .true.
!integer, parameter :: clforce_nskip = 10

integer, parameter :: CD_ramp_nstep = 1000

logical, parameter :: use_beta_sub_regions = .true.
logical, parameter :: use_single_beta_CD = .true.

real(rprec), parameter :: chi_cutoff = 1.e-9_rprec

integer, parameter :: rns_ntree = 2 ! Number of unique trees 
integer, parameter :: rns_tree_layout = 1
!---------------------------------------------------
! 
!---------------------------------------------------  

! ---- Secondary structures ----
type ref_region
  integer :: npoint
  real(rprec), pointer, dimension(:,:) :: points !  3 ordered points
  real(rprec) :: u ! reference values
  real(rprec) :: area
end type ref_region

type force
  integer :: parent !  parent CD; for resolved branches 
  real(rprec) :: fD
  real(rprec) :: CD
  real(rprec) :: kappa ! Used for unresolved branches
end type force

type indx_array
  integer :: npoint
  integer, pointer, dimension(:,:) :: iarray
end type

type child_elem
  integer :: nelem
  integer, pointer, dimension(:) :: iarray
end type child_elem
! ---- Secondary structures ----

! ---- Primary structures ----
type primary_struct_type_1
  type(ref_region)   :: ref_region_t
  type(force)       :: force_t
  type(indx_array)  :: indx_array_t
end type primary_struct_type_1

type primary_struct_type_2
  type(ref_region)   :: ref_region_t
  type(force)       :: force_t
  type(indx_array)  :: indx_array_t
  type(child_elem)  :: r_child_t
  type(child_elem)  :: beta_child_t
end type primary_struct_type_2

type(primary_struct_type_1), pointer, dimension(:) :: r_elem_t
type(primary_struct_type_1), pointer, dimension(:) :: beta_elem_t
type(primary_struct_type_2), pointer, dimension(:) :: b_elem_t
! ---- Primary structures ----


!type(indx_array), pointer, dimension(:) :: cl_indx_array_t
!type(indx_array), pointer, dimension(:) :: beta_indx_array_t

!type(ref_plane), pointer, dimension(:) :: cl_ref_plane_t 	! For resolved clusters only
!type(ref_plane), pointer, dimension(:) :: rbeta_ref_plane_t 	! 
!type(ref_plane), pointer, dimension(:) :: beta_ref_plane_t  ! For unresolved regions

!type(force), pointer, dimension(:) :: brforce_t, clforce_t 	!  For resolved objects only
!type(force), pointer, dimension(:) :: beta_force_t          ! For unresolved regions


!integer :: ncluster_reslv ! total number of resolved clusters
!integer :: nbeta ! number of total beta regions
!integer :: nrbeta ! number of 

!integer, pointer, dimension(:) :: rns_reslv_cl_iarray
!integer, pointer, dimension(:) :: rns_beta_iarray
!integer, pointer, dimension(:) :: rns_rbeta_iarray
!integer, pointer, dimension(:) :: rns_tree_iarray(:) ! This maps the tree number from cyl_skew to the trees considered during rns


real (rprec) :: chi(ld, ny, $lbz:nz)
logical :: chi_initialized = .false.

end module rns_base_ls
