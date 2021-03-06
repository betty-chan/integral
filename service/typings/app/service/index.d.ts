// This file is created by egg-ts-helper@1.25.8
// Do not modify this file!!!!!!!!!

import 'egg';
type AnyClass = new (...args: any[]) => any;
type AnyFunc<T = any> = (...args: any[]) => T;
type CanExportFunc = AnyFunc<Promise<any>> | AnyFunc<IterableIterator<any>>;
type AutoInstanceType<T, U = T extends CanExportFunc ? T : T extends AnyFunc ? ReturnType<T> : T> = U extends AnyClass ? InstanceType<U> : U;
import ExportAchieve from '../../../app/service/achieve';
import ExportGoods from '../../../app/service/goods';
import ExportGrade from '../../../app/service/grade';
import ExportQiniu from '../../../app/service/qiniu';
import ExportRecord from '../../../app/service/record';
import ExportSorce from '../../../app/service/sorce';
import ExportTopic from '../../../app/service/topic';
import ExportUser from '../../../app/service/user';
import ExportWish from '../../../app/service/wish';
import ExportTypeSroceInterface from '../../../app/service/type/sroce-interface';
import ExportTypeTopicInterface from '../../../app/service/type/topic-interface';

declare module 'egg' {
  interface IService {
    achieve: AutoInstanceType<typeof ExportAchieve>;
    goods: AutoInstanceType<typeof ExportGoods>;
    grade: AutoInstanceType<typeof ExportGrade>;
    qiniu: AutoInstanceType<typeof ExportQiniu>;
    record: AutoInstanceType<typeof ExportRecord>;
    sorce: AutoInstanceType<typeof ExportSorce>;
    topic: AutoInstanceType<typeof ExportTopic>;
    user: AutoInstanceType<typeof ExportUser>;
    wish: AutoInstanceType<typeof ExportWish>;
    type: {
      sroceInterface: AutoInstanceType<typeof ExportTypeSroceInterface>;
      topicInterface: AutoInstanceType<typeof ExportTypeTopicInterface>;
    }
  }
}
