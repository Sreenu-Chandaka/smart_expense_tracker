// lib/bloc/expense_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../models/expense.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  late Box<Expense> _expenseBox;

  ExpenseBloc() : super(ExpenseInitial()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<AddExpense>(_onAddExpense);
    on<UpdateExpense>(_onUpdateExpense);
    on<DeleteExpense>(_onDeleteExpense);
    on<ToggleFavorite>(_onToggleFavorite);
    on<RefreshExpenses>(_onRefreshExpenses);
  }

  Future<void> init() async {
    _expenseBox = await Hive.openBox<Expense>('expenses');
    add(LoadExpenses());
  }

  Future<void> _onLoadExpenses(
    LoadExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      emit(ExpenseLoading());
      final expenses = _expenseBox.values.toList()
        ..sort((a, b) => b.date.compareTo(a.date));
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onAddExpense(
    AddExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      await _expenseBox.put(event.expense.id, event.expense);
      add(LoadExpenses());
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onUpdateExpense(
    UpdateExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      await _expenseBox.put(event.expense.id, event.expense);
      add(LoadExpenses());
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onDeleteExpense(
    DeleteExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      await _expenseBox.delete(event.id);
      add(LoadExpenses());
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      final expense = _expenseBox.get(event.id);
      if (expense != null) {
        final updatedExpense = expense.copyWith(
          isFavorite: !expense.isFavorite,
        );
        await _expenseBox.put(event.id, updatedExpense);
        add(LoadExpenses());
      }
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onRefreshExpenses(
    RefreshExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      final expenses = _expenseBox.values.toList()
        ..sort((a, b) => b.date.compareTo(a.date));
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }
}