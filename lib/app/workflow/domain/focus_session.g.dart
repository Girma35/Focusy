// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_session.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFocusSessionCollection on Isar {
  IsarCollection<FocusSession> get focusSessions => this.collection();
}

const FocusSessionSchema = CollectionSchema(
  name: r'FocusSession',
  id: 7529488139707530527,
  properties: {
    r'appsBlocked': PropertySchema(
      id: 0,
      name: r'appsBlocked',
      type: IsarType.bool,
    ),
    r'calendarSynced': PropertySchema(
      id: 1,
      name: r'calendarSynced',
      type: IsarType.bool,
    ),
    r'controlledModeEnabled': PropertySchema(
      id: 2,
      name: r'controlledModeEnabled',
      type: IsarType.bool,
    ),
    r'date': PropertySchema(
      id: 3,
      name: r'date',
      type: IsarType.string,
    ),
    r'phase': PropertySchema(
      id: 4,
      name: r'phase',
      type: IsarType.long,
    ),
    r'planningEndsAt': PropertySchema(
      id: 5,
      name: r'planningEndsAt',
      type: IsarType.dateTime,
    ),
    r'strictFocusEnabled': PropertySchema(
      id: 6,
      name: r'strictFocusEnabled',
      type: IsarType.bool,
    ),
    r'wakeUpTime': PropertySchema(
      id: 7,
      name: r'wakeUpTime',
      type: IsarType.dateTime,
    ),
    r'workEndTime': PropertySchema(
      id: 8,
      name: r'workEndTime',
      type: IsarType.dateTime,
    ),
    r'workStartTime': PropertySchema(
      id: 9,
      name: r'workStartTime',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _focusSessionEstimateSize,
  serialize: _focusSessionSerialize,
  deserialize: _focusSessionDeserialize,
  deserializeProp: _focusSessionDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _focusSessionGetId,
  getLinks: _focusSessionGetLinks,
  attach: _focusSessionAttach,
  version: '3.1.0+1',
);

int _focusSessionEstimateSize(
  FocusSession object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.date.length * 3;
  return bytesCount;
}

void _focusSessionSerialize(
  FocusSession object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.appsBlocked);
  writer.writeBool(offsets[1], object.calendarSynced);
  writer.writeBool(offsets[2], object.controlledModeEnabled);
  writer.writeString(offsets[3], object.date);
  writer.writeLong(offsets[4], object.phase);
  writer.writeDateTime(offsets[5], object.planningEndsAt);
  writer.writeBool(offsets[6], object.strictFocusEnabled);
  writer.writeDateTime(offsets[7], object.wakeUpTime);
  writer.writeDateTime(offsets[8], object.workEndTime);
  writer.writeDateTime(offsets[9], object.workStartTime);
}

FocusSession _focusSessionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FocusSession(
    appsBlocked: reader.readBoolOrNull(offsets[0]) ?? false,
    calendarSynced: reader.readBoolOrNull(offsets[1]) ?? false,
    controlledModeEnabled: reader.readBoolOrNull(offsets[2]) ?? false,
    date: reader.readString(offsets[3]),
    id: id,
    phase: reader.readLongOrNull(offsets[4]) ?? 0,
    planningEndsAt: reader.readDateTimeOrNull(offsets[5]),
    strictFocusEnabled: reader.readBoolOrNull(offsets[6]) ?? false,
    wakeUpTime: reader.readDateTimeOrNull(offsets[7]),
    workEndTime: reader.readDateTimeOrNull(offsets[8]),
    workStartTime: reader.readDateTimeOrNull(offsets[9]),
  );
  return object;
}

P _focusSessionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _focusSessionGetId(FocusSession object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _focusSessionGetLinks(FocusSession object) {
  return [];
}

void _focusSessionAttach(
    IsarCollection<dynamic> col, Id id, FocusSession object) {
  object.id = id;
}

extension FocusSessionByIndex on IsarCollection<FocusSession> {
  Future<FocusSession?> getByDate(String date) {
    return getByIndex(r'date', [date]);
  }

  FocusSession? getByDateSync(String date) {
    return getByIndexSync(r'date', [date]);
  }

  Future<bool> deleteByDate(String date) {
    return deleteByIndex(r'date', [date]);
  }

  bool deleteByDateSync(String date) {
    return deleteByIndexSync(r'date', [date]);
  }

  Future<List<FocusSession?>> getAllByDate(List<String> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndex(r'date', values);
  }

  List<FocusSession?> getAllByDateSync(List<String> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'date', values);
  }

  Future<int> deleteAllByDate(List<String> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'date', values);
  }

  int deleteAllByDateSync(List<String> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'date', values);
  }

  Future<Id> putByDate(FocusSession object) {
    return putByIndex(r'date', object);
  }

  Id putByDateSync(FocusSession object, {bool saveLinks = true}) {
    return putByIndexSync(r'date', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDate(List<FocusSession> objects) {
    return putAllByIndex(r'date', objects);
  }

  List<Id> putAllByDateSync(List<FocusSession> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'date', objects, saveLinks: saveLinks);
  }
}

extension FocusSessionQueryWhereSort
    on QueryBuilder<FocusSession, FocusSession, QWhere> {
  QueryBuilder<FocusSession, FocusSession, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FocusSessionQueryWhere
    on QueryBuilder<FocusSession, FocusSession, QWhereClause> {
  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> dateEqualTo(
      String date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> dateNotEqualTo(
      String date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ));
      }
    });
  }
}

extension FocusSessionQueryFilter
    on QueryBuilder<FocusSession, FocusSession, QFilterCondition> {
  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      appsBlockedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appsBlocked',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      calendarSyncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calendarSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      controlledModeEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'controlledModeEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> dateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      dateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> dateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> dateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      dateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> dateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> dateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> dateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'date',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      dateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      dateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> phaseEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phase',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      phaseGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phase',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> phaseLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phase',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> phaseBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phase',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      planningEndsAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'planningEndsAt',
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      planningEndsAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'planningEndsAt',
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      planningEndsAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'planningEndsAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      planningEndsAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'planningEndsAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      planningEndsAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'planningEndsAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      planningEndsAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'planningEndsAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      strictFocusEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'strictFocusEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      wakeUpTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'wakeUpTime',
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      wakeUpTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'wakeUpTime',
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      wakeUpTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wakeUpTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      wakeUpTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'wakeUpTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      wakeUpTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'wakeUpTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      wakeUpTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'wakeUpTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      workEndTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'workEndTime',
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      workEndTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'workEndTime',
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      workEndTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workEndTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      workEndTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workEndTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      workEndTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workEndTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      workEndTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workEndTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      workStartTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'workStartTime',
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      workStartTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'workStartTime',
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      workStartTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workStartTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      workStartTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workStartTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      workStartTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workStartTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      workStartTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workStartTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FocusSessionQueryObject
    on QueryBuilder<FocusSession, FocusSession, QFilterCondition> {}

extension FocusSessionQueryLinks
    on QueryBuilder<FocusSession, FocusSession, QFilterCondition> {}

extension FocusSessionQuerySortBy
    on QueryBuilder<FocusSession, FocusSession, QSortBy> {
  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByAppsBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appsBlocked', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      sortByAppsBlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appsBlocked', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      sortByCalendarSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarSynced', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      sortByCalendarSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarSynced', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      sortByControlledModeEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'controlledModeEnabled', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      sortByControlledModeEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'controlledModeEnabled', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByPhase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phase', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByPhaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phase', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      sortByPlanningEndsAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planningEndsAt', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      sortByPlanningEndsAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planningEndsAt', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      sortByStrictFocusEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strictFocusEnabled', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      sortByStrictFocusEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strictFocusEnabled', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByWakeUpTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wakeUpTime', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      sortByWakeUpTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wakeUpTime', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByWorkEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workEndTime', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      sortByWorkEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workEndTime', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByWorkStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workStartTime', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      sortByWorkStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workStartTime', Sort.desc);
    });
  }
}

extension FocusSessionQuerySortThenBy
    on QueryBuilder<FocusSession, FocusSession, QSortThenBy> {
  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByAppsBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appsBlocked', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      thenByAppsBlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appsBlocked', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      thenByCalendarSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarSynced', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      thenByCalendarSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarSynced', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      thenByControlledModeEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'controlledModeEnabled', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      thenByControlledModeEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'controlledModeEnabled', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByPhase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phase', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByPhaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phase', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      thenByPlanningEndsAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planningEndsAt', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      thenByPlanningEndsAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planningEndsAt', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      thenByStrictFocusEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strictFocusEnabled', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      thenByStrictFocusEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strictFocusEnabled', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByWakeUpTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wakeUpTime', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      thenByWakeUpTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wakeUpTime', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByWorkEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workEndTime', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      thenByWorkEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workEndTime', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByWorkStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workStartTime', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      thenByWorkStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workStartTime', Sort.desc);
    });
  }
}

extension FocusSessionQueryWhereDistinct
    on QueryBuilder<FocusSession, FocusSession, QDistinct> {
  QueryBuilder<FocusSession, FocusSession, QDistinct> distinctByAppsBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appsBlocked');
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct>
      distinctByCalendarSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calendarSynced');
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct>
      distinctByControlledModeEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'controlledModeEnabled');
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct> distinctByDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct> distinctByPhase() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phase');
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct>
      distinctByPlanningEndsAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'planningEndsAt');
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct>
      distinctByStrictFocusEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'strictFocusEnabled');
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct> distinctByWakeUpTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wakeUpTime');
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct> distinctByWorkEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workEndTime');
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct>
      distinctByWorkStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workStartTime');
    });
  }
}

extension FocusSessionQueryProperty
    on QueryBuilder<FocusSession, FocusSession, QQueryProperty> {
  QueryBuilder<FocusSession, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FocusSession, bool, QQueryOperations> appsBlockedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appsBlocked');
    });
  }

  QueryBuilder<FocusSession, bool, QQueryOperations> calendarSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calendarSynced');
    });
  }

  QueryBuilder<FocusSession, bool, QQueryOperations>
      controlledModeEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'controlledModeEnabled');
    });
  }

  QueryBuilder<FocusSession, String, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<FocusSession, int, QQueryOperations> phaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phase');
    });
  }

  QueryBuilder<FocusSession, DateTime?, QQueryOperations>
      planningEndsAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'planningEndsAt');
    });
  }

  QueryBuilder<FocusSession, bool, QQueryOperations>
      strictFocusEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'strictFocusEnabled');
    });
  }

  QueryBuilder<FocusSession, DateTime?, QQueryOperations> wakeUpTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wakeUpTime');
    });
  }

  QueryBuilder<FocusSession, DateTime?, QQueryOperations>
      workEndTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workEndTime');
    });
  }

  QueryBuilder<FocusSession, DateTime?, QQueryOperations>
      workStartTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workStartTime');
    });
  }
}
