// This file is created by egg-ts-helper@1.25.8
// Do not modify this file!!!!!!!!!

import 'egg';
import ExportAuthorization from '../../../app/middleware/authorization';
import ExportErrorHandler from '../../../app/middleware/error_handler';

declare module 'egg' {
  interface IMiddleware {
    authorization: typeof ExportAuthorization;
    errorHandler: typeof ExportErrorHandler;
  }
}
