#include "antsUtilities.h"
#include <algorithm>

#include "itkImageFileReader.h"
#include "itkImageFileWriter.h"

#include "itkDeformationFieldGradientTensorImageFilter.h"
#include "itkDeterminantTensorImageFilter.h"
#include "itkVectorTensorImageFilter.h"
#include "itkGeometricJacobianDeterminantImageFilter.h"
#include "itkLogImageFilter.h"
#include "itkMaximumImageFilter.h"

namespace ants
{
template <unsigned int ImageDimension, unsigned int NumberOfComponents>
int CreateJacobianMatrixImage( char *argv[] )
{
  typedef double RealType;
  typedef itk::Image<RealType, ImageDimension> ImageType;
  typedef itk::Vector<RealType, ImageDimension> VectorType;
  typedef itk::Image<VectorType, ImageDimension> VectorImageType;

  typedef itk::Vector<RealType, NumberOfComponents> VectorPixelType;
  typedef itk::Image<VectorPixelType, ImageDimension> VectorPixelImageType;

  /**
   * Read in vector field
   */
  typedef itk::ImageFileReader<VectorImageType> ReaderType;
  typename ReaderType::Pointer reader = ReaderType::New();
  reader->SetFileName( argv[2] );
  reader->Update();

  typename ImageType::Pointer jacobian = NULL;

  typename ImageType::Pointer minimumConstantImage = ImageType::New();
  minimumConstantImage->CopyInformation( reader->GetOutput() );
  minimumConstantImage->SetRegions( reader->GetOutput()->GetRequestedRegion() );
  minimumConstantImage->Allocate();
  minimumConstantImage->FillBuffer( 0.001 );

  typedef itk::DeformationFieldGradientTensorImageFilter<VectorImageType, RealType> JacobianFilterType;
  typename JacobianFilterType::Pointer jacobianFilter = JacobianFilterType::New();
  jacobianFilter->SetInput( reader->GetOutput() );
  jacobianFilter->SetCalculateJacobian( true );
  jacobianFilter->SetUseImageSpacing( true );
  // jacobianFilter->SetOrder( 2 );
  // 08/22/2016 11:08 a.m.
  jacobianFilter->SetOrder( 1 );
  jacobianFilter->SetUseCenteredDifference( true );

  typedef itk::VectorTensorImageFilter<typename JacobianFilterType::OutputImageType, RealType, VectorPixelType>
      VectorFilterType;
  typename VectorFilterType::Pointer vectorFilter = VectorFilterType::New();
  vectorFilter->SetInput( jacobianFilter->GetOutput() );
  vectorFilter->Update();

  typedef itk::ImageFileWriter<VectorPixelImageType> ImageWriterType;
  typename ImageWriterType::Pointer writer = ImageWriterType::New();
  writer->SetFileName( argv[3] );
  writer->SetInput( vectorFilter->GetOutput() );
  writer->Update();

  return EXIT_SUCCESS;
}

// entry point for the library; parameter 'args' is equivalent to 'argv' in (argc,argv) of commandline parameters to
// 'main()'
int CreateJacobianMatrixImage( std::vector<std::string> args, std::ostream* itkNotUsed( out_stream ) )
{
  // put the arguments coming in as 'args' into standard (argc,argv) format;
  // 'args' doesn't have the command name as first, argument, so add it manually;
  // 'args' may have adjacent arguments concatenated into one argument,
  // which the parser should handle
  args.insert( args.begin(), "CreateJacobianMatrixImage" );

  int     argc = args.size();
  char* * argv = new char *[args.size() + 1];
  for( unsigned int i = 0; i < args.size(); ++i )
    {
    // allocate space for the string plus a null character
    argv[i] = new char[args[i].length() + 1];
    std::strncpy( argv[i], args[i].c_str(), args[i].length() );
    // place the null character in the end
    argv[i][args[i].length()] = '\0';
    }
  argv[argc] = 0;
  // class to automatically cleanup argv upon destruction
  class Cleanup_argv
  {
public:
    Cleanup_argv( char* * argv_, int argc_plus_one_ ) : argv( argv_ ), argc_plus_one( argc_plus_one_ )
    {
    }

    ~Cleanup_argv()
    {
      for( unsigned int i = 0; i < argc_plus_one; ++i )
        {
        delete[] argv[i];
        }
      delete[] argv;
    }

private:
    char* *      argv;
    unsigned int argc_plus_one;
  };
  Cleanup_argv cleanup_argv( argv, argc + 1 );

  // antscout->set_stream( out_stream );

  if( argc < 3 )
    {
    std::cout << "Usage: " << argv[0] << " imageDimension deformationField outputMatrixImage " << std::endl;
    return EXIT_FAILURE;
    }

  switch( atoi( argv[1] ) )
    {
    case 2:
      {
      CreateJacobianMatrixImage<2,4>( argv );
      }
      break;
    case 3:
      {
      CreateJacobianMatrixImage<3,9>( argv );
      }
      break;
    default:
      std::cout << "Unsupported dimension" << std::endl;
      return EXIT_FAILURE;
    }
  return EXIT_SUCCESS;
}
} // namespace ants
