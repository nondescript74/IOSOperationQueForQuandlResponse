# IOSOperationQueForQuandlResponse
Retrieving, serializing, decoding and post processing operations on multiple data streams require threading

An Example:
Needing to get a response and then post process the dataset fron www.quandl.com (or other web service) via an API provided by Quandl.

Keeping the user interface highly responsive when expensive operations are being performed is always necessary since the user could have many requests for such information happening at the same time which would bring a non concurrent application to its knees as far as responsiveness is concerned.

Significant learning can be had by visiting www.raywenderlich.com .
Many thanks to them for teaching me how to do this.

www.Cocoacasts.com is also a great resource to learn these subjects.
