#include "imgshow.h"
void show()
{

  cv::Mat src = cv::imread("1.jpg");
  cv::imshow("main", src);
  cv::waitKey(0);

}
