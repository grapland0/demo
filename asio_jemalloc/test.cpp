#include <iostream>

#include <boost/asio.hpp>
#include <boost/asio/spawn.hpp>

int main() {
  boost::asio::io_context ioc;
  boost::asio::spawn(
      ioc,
      [&](boost::asio::yield_context y) {
        auto wg = boost::asio::make_work_guard(ioc);
        return boost::asio::async_initiate<boost::asio::yield_context,
                                           void(boost::system::error_code)>(
            [](auto handler) { std::move(handler)({}); }, y);
      },
      boost::asio::detached);
  ioc.run();
  std::cout << "I'm good." << std::endl;
  return 0;
}